#ifndef OSMIUM_OBJECT_POINTER_COLLECTION_HPP
#define OSMIUM_OBJECT_POINTER_COLLECTION_HPP

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
#include <utility>
#include <vector>

#include <boost/iterator/indirect_iterator.hpp>

#include <osmium/handler.hpp>
#include <osmium/memory/item.hpp>
#include <osmium/osm/object.hpp>

// IWYU pragma: no_forward_declare osmium::OSMObject
// IWYU pragma: no_forward_declare osmium::memory::Item

namespace osmium {

    /**
     * A collection of pointers to OSM objects. The pointers can be easily
     * and quickly sorted or otherwise manipulated, while the objects
     * themselves or the buffers they are in, do not have to be changed.
     *
     * An iterator is provided that can iterate over the pointers but looks
     * like it is iterating over the underlying OSM objects.
     *
     * This class implements the visitor pattern which makes it easy to
     * populate the collection from a buffer of OSM objects:
     *
     *   osmium::ObjectPointerCollection objects;
     *   osmium::memory::Buffer buffer = reader.read();
     *   osmium::apply(buffer, objects);
     *
     */
    class ObjectPointerCollection : public osmium::handler::Handler {

        std::vector<osmium::OSMObject*> m_objects;

    public:

        typedef boost::indirect_iterator<std::vector<osmium::OSMObject*>::iterator, osmium::OSMObject> iterator;
        typedef boost::indirect_iterator<std::vector<osmium::OSMObject*>::const_iterator, const osmium::OSMObject> const_iterator;

        ObjectPointerCollection() noexcept :
            m_objects() {
        }

        void osm_object(osmium::OSMObject& object) {
            m_objects.push_back(&object);
        }

        /**
         * Sort objects according to the given order functor.
         */
        template <class TCompare>
        void sort(TCompare&& compare) {
            std::sort(m_objects.begin(), m_objects.end(), std::forward<TCompare>(compare));
        }

        iterator begin() {
            return iterator { m_objects.begin() };
        }

        iterator end() {
            return iterator { m_objects.end() };
        }

        const_iterator cbegin() const {
            return const_iterator { m_objects.cbegin() };
        }

        const_iterator cend() const {
            return const_iterator { m_objects.cend() };
        }

    }; // class ObjectPointerCollection

} // namespace osmium

#endif // OSMIUM_OBJECT_POINTER_COLLECTION_HPP
