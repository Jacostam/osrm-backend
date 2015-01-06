#ifndef OSMIUM_IO_DETAIL_PBF_INPUT_FORMAT_HPP
#define OSMIUM_IO_DETAIL_PBF_INPUT_FORMAT_HPP

/*

This file is part of Osmium (http://osmcode.org/libosmium).

Copyright 2013,2014 Jochen Topf <jochen@topf.org> and others (see README).

Boost Software License - Version 1.0 - August 17th, 2003

Permission is hereby granted, free of charge, to any person or organization
obtaining a copy of the software and accompanying documentation covered by
this license (the "Software") to use, reproduce, display, distribute,
execute, and transmit the Software, and to prepare derivative works of the
Software, and to permit third-parties to whom the Software is furnished to
do so, all subject to the following:

The copyright notices in the Software and this entire statement, including
the above license grant, this restriction and the following disclaimer,
must be included in all copies of the Software, in whole or in part, and
all derivative works of the Software, unless such copies or derivative
works are solely in the form of machine-executable object code generated by
a source language processor.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE, TITLE AND NON-INFRINGEMENT. IN NO EVENT
SHALL THE COPYRIGHT HOLDERS OR ANYONE DISTRIBUTING THE SOFTWARE BE LIABLE
FOR ANY DAMAGES OR OTHER LIABILITY, WHETHER IN CONTRACT, TORT OR OTHERWISE,
ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
DEALINGS IN THE SOFTWARE.

*/

#include <algorithm>
#include <atomic>
#include <cassert>
#include <chrono>
#include <cstddef>
#include <cstdint>
#include <cstring>
#include <future>
#include <memory>
#include <ratio>
#include <sstream>
#include <stdexcept>
#include <string>
#include <thread>
#include <type_traits>

#include <osmium/io/detail/input_format.hpp>
#include <osmium/io/detail/pbf.hpp> // IWYU pragma: export
#include <osmium/io/detail/pbf_parser.hpp>
#include <osmium/io/error.hpp>
#include <osmium/io/file.hpp>
#include <osmium/io/file_format.hpp>
#include <osmium/memory/buffer.hpp>
#include <osmium/osm.hpp>
#include <osmium/osm/box.hpp>
#include <osmium/osm/entity_bits.hpp>
#include <osmium/osm/location.hpp>
#include <osmium/osm/object.hpp>
#include <osmium/osm/timestamp.hpp>
#include <osmium/thread/pool.hpp>
#include <osmium/thread/queue.hpp>
#include <osmium/thread/util.hpp>
#include <osmium/util/cast.hpp>
#include <osmium/util/config.hpp>

namespace osmium {

    namespace io {

        class File;

        namespace detail {

            typedef osmium::thread::Queue<std::future<osmium::memory::Buffer>> queue_type;

            /**
             * Class for parsing PBF files.
             */
            class PBFInputFormat : public osmium::io::detail::InputFormat {

                bool m_use_thread_pool;
                queue_type m_queue;
                std::atomic<bool> m_done;
                std::thread m_reader;
                osmium::thread::Queue<std::string>& m_input_queue;
                std::string m_input_buffer;

                /**
                 * Read the given number of bytes from the input queue.
                 *
                 * @param size Number of bytes to read
                 * @returns String with the data
                 * @throws osmium::pbf_error If size bytes can't be read
                 */
                std::string read_from_input_queue(size_t size) {
                    while (m_input_buffer.size() < size) {
                        std::string new_data;
                        m_input_queue.wait_and_pop(new_data);
                        if (new_data.empty()) {
                            throw osmium::pbf_error("truncated data (EOF encountered)");
                        }
                        m_input_buffer += new_data;
                    }

                    std::string output { m_input_buffer.substr(size) };
                    m_input_buffer.resize(size);
                    std::swap(output, m_input_buffer);
                    return output;
                }

                /**
                 * Read BlobHeader by first reading the size and then the
                 * BlobHeader. The BlobHeader contains a type field (which is
                 * checked against the expected type) and a size field.
                 *
                 * @param expected_type Expected type of data ("OSMHeader" or
                 *                      "OSMData").
                 * @returns Size of the data read from BlobHeader (0 on EOF).
                 */
                size_t read_blob_header(const char* expected_type) {
                    uint32_t size_in_network_byte_order;

                    try {
                        std::string input_data = read_from_input_queue(sizeof(size_in_network_byte_order));
                        size_in_network_byte_order = *reinterpret_cast<const uint32_t*>(input_data.data());
                    } catch (osmium::pbf_error&) {
                        return 0; // EOF
                    }

                    uint32_t size = ntohl(size_in_network_byte_order);
                    if (size > static_cast<uint32_t>(OSMPBF::max_blob_header_size)) {
                        throw osmium::pbf_error("invalid BlobHeader size (> max_blob_header_size)");
                    }

                    OSMPBF::BlobHeader blob_header;
                    if (!blob_header.ParseFromString(read_from_input_queue(size))) {
                        throw osmium::pbf_error("failed to parse BlobHeader");
                    }

                    if (blob_header.type() != expected_type) {
                        throw osmium::pbf_error("blob does not have expected type (OSMHeader in first blob, OSMData in following blobs)");
                    }

                    return static_cast<size_t>(blob_header.datasize());
                }

                void parse_osm_data(osmium::osm_entity_bits::type read_types) {
                    osmium::thread::set_thread_name("_osmium_pbf_in");
                    int n=0;
                    while (auto size = read_blob_header("OSMData")) {

                        if (m_use_thread_pool) {
                            m_queue.push(osmium::thread::Pool::instance().submit(DataBlobParser{read_from_input_queue(size), read_types}));
                        } else {
                            std::promise<osmium::memory::Buffer> promise;
                            m_queue.push(promise.get_future());
                            DataBlobParser data_blob_parser{read_from_input_queue(size), read_types};
                            promise.set_value(data_blob_parser());
                        }
                        ++n;

                        if (m_done) {
                            return;
                        }
                    }
                    m_done = true;
                }

            public:

                /**
                 * Instantiate PBF Parser
                 *
                 * @param file osmium::io::File instance describing file to be read from.
                 * @param read_which_entities Which types of OSM entities (nodes, ways, relations, changesets) should be parsed?
                 * @param input_queue String queue where data is read from.
                 */
                PBFInputFormat(const osmium::io::File& file, osmium::osm_entity_bits::type read_which_entities, osmium::thread::Queue<std::string>& input_queue) :
                    osmium::io::detail::InputFormat(file, read_which_entities, input_queue),
                    m_use_thread_pool(osmium::config::use_pool_threads_for_pbf_parsing()),
                    m_queue(20, "pbf_parser_results"), // XXX
                    m_done(false),
                    m_input_queue(input_queue),
                    m_input_buffer() {
                    GOOGLE_PROTOBUF_VERIFY_VERSION;

                    // handle OSMHeader
                    auto size = read_blob_header("OSMHeader");
                    m_header = parse_header_blob(read_from_input_queue(size));

                    if (m_read_which_entities != osmium::osm_entity_bits::nothing) {
                        m_reader = std::thread(&PBFInputFormat::parse_osm_data, this, m_read_which_entities);
                    }
                }

                ~PBFInputFormat() {
                    m_done = true;
                    if (m_reader.joinable()) {
                        m_reader.join();
                    }
                }

                /**
                 * Returns the next buffer with OSM data read from the PBF file.
                 * Blocks if data is not available yet.
                 * Returns an empty buffer at end of input.
                 */
                osmium::memory::Buffer read() override {
                    if (!m_done || !m_queue.empty()) {
                        std::future<osmium::memory::Buffer> buffer_future;
                        m_queue.wait_and_pop(buffer_future);
                        return std::move(buffer_future.get());
                    }

                    return osmium::memory::Buffer();
                }

            }; // class PBFInputFormat

            namespace {

                const bool registered_pbf_input = osmium::io::detail::InputFormatFactory::instance().register_input_format(osmium::io::file_format::pbf,
                    [](const osmium::io::File& file, osmium::osm_entity_bits::type read_which_entities, osmium::thread::Queue<std::string>& input_queue) {
                        return new osmium::io::detail::PBFInputFormat(file, read_which_entities, input_queue);
                });

            } // anonymous namespace

        } // namespace detail

    } // namespace io

} // namespace osmium

#endif // OSMIUM_IO_DETAIL_PBF_INPUT_FORMAT_HPP
