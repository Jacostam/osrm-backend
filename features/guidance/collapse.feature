@routing  @guidance @collapsing
Feature: Collapse

    Background:
        Given the profile "car"
        Given a grid size of 20 meters

    Scenario: Segregated Intersection, Cross Belonging to Single Street
        Given the node map
            """
                i l

            d   c b   a
            e   f g   h

                j k
            """

        And the ways
            | nodes | highway | name   | oneway |
            | ab    | primary | first  | yes    |
            | bc    | primary | first  | yes    |
            | cd    | primary | first  | yes    |
            | ef    | primary | first  | yes    |
            | fg    | primary | first  | yes    |
            | gh    | primary | first  | yes    |
            | ic    | primary | second | yes    |
            | bl    | primary | second | yes    |
            | kg    | primary | second | yes    |
            | fj    | primary | second | yes    |
            | cf    | primary | first  | yes    |
            | gb    | primary | first  | yes    |

       When I route I should get
            | waypoints | route                | turns                        | locations |
            | a,l       | first,second,second  | depart,turn right,arrive     | a,b,l     |
            | a,d       | first,first          | depart,arrive                | a,d       |
            | a,j       | first,second,second  | depart,turn left,arrive      | a,c,j     |
            | a,h       | first,first,first    | depart,continue uturn,arrive | a,c,h     |
            | e,j       | first,second,second  | depart,turn right,arrive     | e,f,j     |
            | e,h       | first,first          | depart,arrive                | e,h       |
            | e,l       | first,second,second  | depart,turn left,arrive      | e,g,l     |
            | e,d       | first,first,first    | depart,continue uturn,arrive | e,g,d     |
            | k,h       | second,first,first   | depart,turn right,arrive     | k,g,h     |
            | k,l       | second,second        | depart,arrive                | k,l       |
            | k,d       | second,first,first   | depart,turn left,arrive      | k,b,d     |
            | k,j       | second,second,second | depart,continue uturn,arrive | k,b,j     |
            | i,d       | second,first,first   | depart,turn right,arrive     | i,c,d     |
            | i,j       | second,second        | depart,arrive                | i,j       |
            | i,h       | second,first,first   | depart,turn left,arrive      | i,f,h     |
            | i,l       | second,second,second | depart,continue uturn,arrive | i,f,l     |

    Scenario: Segregated Intersection, Cross Belonging to Correct Street
        Given the node map
            """
                i l

            d   c b   a
            e   f g   h

                j k
            """

        And the ways
            | nodes | highway | name   | oneway |
            | ab    | primary | first  | yes    |
            | bc    | primary | first  | yes    |
            | cd    | primary | first  | yes    |
            | ef    | primary | first  | yes    |
            | fg    | primary | first  | yes    |
            | gh    | primary | first  | yes    |
            | ic    | primary | second | yes    |
            | bl    | primary | second | yes    |
            | kg    | primary | second | yes    |
            | fj    | primary | second | yes    |
            | cf    | primary | second | yes    |
            | gb    | primary | second | yes    |

       When I route I should get
            | waypoints | route                | turns                        | locations |
            | a,l       | first,second,second  | depart,turn right,arrive     | a,b,l     |
            | a,d       | first,first          | depart,arrive                | a,d       |
            | a,j       | first,second,second  | depart,turn left,arrive      | a,c,j     |
            | a,h       | first,first,first    | depart,continue uturn,arrive | a,c,h     |
            | e,j       | first,second,second  | depart,turn right,arrive     | e,f,j     |
            | e,h       | first,first          | depart,arrive                | e,h       |
            | e,l       | first,second,second  | depart,turn left,arrive      | e,g,l     |
            | e,d       | first,first,first    | depart,continue uturn,arrive | e,g,d     |
            | k,h       | second,first,first   | depart,turn right,arrive     | k,g,h     |
            | k,l       | second,second        | depart,arrive                | k,l       |
            | k,d       | second,first,first   | depart,turn left,arrive      | k,b,d     |
            | k,j       | second,second,second | depart,continue uturn,arrive | k,b,j     |
            | i,d       | second,first,first   | depart,turn right,arrive     | i,c,d     |
            | i,j       | second,second        | depart,arrive                | i,j       |
            | i,h       | second,first,first   | depart,turn left,arrive      | i,f,h     |
            | i,l       | second,second,second | depart,continue uturn,arrive | i,f,l     |

    Scenario: Segregated Intersection, Cross Belonging to Mixed Streets
        Given the node map
            """
                i l

            d   c b   a
            e   f g   h

                j k
            """

        And the ways
            | nodes | highway | name   | oneway |
            | ab    | primary | first  | yes    |
            | bc    | primary | second | yes    |
            | cd    | primary | first  | yes    |
            | ef    | primary | first  | yes    |
            | fg    | primary | first  | yes    |
            | gh    | primary | first  | yes    |
            | ic    | primary | second | yes    |
            | bl    | primary | second | yes    |
            | kg    | primary | second | yes    |
            | fj    | primary | second | yes    |
            | cf    | primary | second | yes    |
            | gb    | primary | first  | yes    |

       When I route I should get
            | waypoints | route                | turns                        | locations |
            | a,l       | first,second,second  | depart,turn right,arrive     | a,b,l     |
            | a,d       | first,first          | depart,arrive                | a,d       |
            | a,j       | first,second,second  | depart,turn left,arrive      | a,c,j     |
            | a,h       | first,first,first    | depart,continue uturn,arrive | a,c,h     |
            | e,j       | first,second,second  | depart,turn right,arrive     | e,f,j     |
            | e,h       | first,first          | depart,arrive                | e,h       |
            | e,l       | first,second,second  | depart,turn left,arrive      | e,g,l     |
            | e,d       | first,first,first    | depart,continue uturn,arrive | e,g,d     |
            | k,h       | second,first,first   | depart,turn right,arrive     | k,g,h     |
            | k,l       | second,second        | depart,arrive                | k,l       |
            | k,d       | second,first,first   | depart,turn left,arrive      | k,b,d     |
            | k,j       | second,second,second | depart,continue uturn,arrive | k,b,j     |
            | i,d       | second,first,first   | depart,turn right,arrive     | i,c,d     |
            | i,j       | second,second        | depart,arrive                | i,j       |
            | i,h       | second,first,first   | depart,turn left,arrive      | i,f,h     |
            | i,l       | second,second,second | depart,continue uturn,arrive | i,f,l     |

    Scenario: Partly Segregated Intersection, Two Segregated Roads
        Given the node map
            """
               n m
               | |
               | |
               | |
               | |
               | |
               g h
            c - b - a
            d - e - f
               j i
               | |
               | |
               | |
               | |
               | |
               k l
            """

        And the ways
            | nodes | highway | name   | oneway | lanes |
            | ab    | primary | first  | yes    |       |
            | bc    | primary | first  | yes    |       |
            | de    | primary | first  | yes    |       |
            | ef    | primary | first  | yes    |       |
            | be    | primary | first  | no     |       |
            | ngbhm | primary | second | yes    | 5     |
            | liejk | primary | second | yes    | 5     |

       When I route I should get
            | waypoints | route                | turns                        | locations |
            | a,h       | first,second,second  | depart,turn right,arrive     | a,b,h     |
            | a,c       | first,first          | depart,arrive                | a,c       |
            | a,j       | first,second,second  | depart,turn left,arrive      | a,b,j     |
            | a,f       | first,first,first    | depart,continue uturn,arrive | a,b,f     |
            | d,j       | first,second,second  | depart,turn right,arrive     | d,e,j     |
            | d,f       | first,first          | depart,arrive                | d,f       |
            | d,h       | first,second,second  | depart,turn left,arrive      | d,e,h     |
            | d,c       | first,first,first    | depart,continue uturn,arrive | d,e,c     |
            | g,c       | second,first,first   | depart,turn right,arrive     | g,b,c     |
            | g,j       | second,second        | depart,arrive                | g,j       |
            | g,f       | second,first,first   | depart,turn left,arrive      | g,e,f     |
            | g,h       | second,second,second | depart,continue uturn,arrive | g,b,h     |
            | i,f       | second,first,first   | depart,turn right,arrive     | i,e,f     |
            | i,h       | second,second        | depart,arrive                | i,h       |
            | i,c       | second,first,first   | depart,turn left,arrive      | i,b,c     |
            | i,j       | second,second,second | depart,continue uturn,arrive | i,e,j     |

    Scenario: Partly Segregated Intersection, Two Segregated Roads, Intersection belongs to Second
        Given the node map
            """
               n m
               | |
               | |
               | |
               | |
               | |
               | |
               g h
               \ /
            c - b - a
            d - e - f
               / \
               j i
               | |
               | |
               | |
               | |
               | |
               | |
               k l
            """

        And the ways
            | nodes | highway | name   | oneway | lanes |
            | ab    | primary | first  | yes    |       |
            | bc    | primary | first  | yes    |       |
            | de    | primary | first  | yes    |       |
            | ef    | primary | first  | yes    |       |
            | be    | primary | second | no     |       |
            | ngbhm | primary | second | yes    | 5     |
            | liejk | primary | second | yes    | 5     |

       When I route I should get
            | waypoints | route                | turns                        | locations |
            | a,h       | first,second,second  | depart,turn right,arrive     | a,b,h     |
            | a,c       | first,first          | depart,arrive                | a,c       |
            | a,j       | first,second,second  | depart,turn left,arrive      | a,b,j     |
            | a,f       | first,first,first    | depart,continue uturn,arrive | a,b,f     |
            | d,j       | first,second,second  | depart,turn right,arrive     | d,e,j     |
            | d,f       | first,first          | depart,arrive                | d,f       |
            | d,h       | first,second,second  | depart,turn left,arrive      | d,e,h     |
            | d,c       | first,first,first    | depart,continue uturn,arrive | d,e,c     |
            | g,c       | second,first,first   | depart,turn right,arrive     | g,b,c     |
            | g,j       | second,second        | depart,arrive                | g,j       |
            | g,f       | second,first,first   | depart,turn left,arrive      | g,e,f     |
            | g,h       | second,second,second | depart,continue uturn,arrive | g,b,h     |
            | i,f       | second,first,first   | depart,turn right,arrive     | i,e,f     |
            | i,h       | second,second        | depart,arrive                | i,h       |
            | i,c       | second,first,first   | depart,turn left,arrive      | i,b,c     |
            | i,j       | second,second,second | depart,continue uturn,arrive | i,e,j     |

    Scenario: Segregated Intersection, Cross Belonging to Mixed Streets - Slight Angles
        Given the node map
            """
                i l
                      a
                c b   h
            d   f g
            e
                j k
            """

        And the ways
            | nodes | highway | name   | oneway |
            | ab    | primary | first  | yes    |
            | bc    | primary | second | yes    |
            | cd    | primary | first  | yes    |
            | ef    | primary | first  | yes    |
            | fg    | primary | first  | yes    |
            | gh    | primary | first  | yes    |
            | ic    | primary | second | yes    |
            | bl    | primary | second | yes    |
            | kg    | primary | second | yes    |
            | fj    | primary | second | yes    |
            | cf    | primary | second | yes    |
            | gb    | primary | first  | yes    |

       When I route I should get
            | waypoints | route                | turns                        | locations |
            | a,l       | first,second,second  | depart,turn right,arrive     | a,b,l     |
            | a,d       | first,first          | depart,arrive                | a,d       |
            | a,j       | first,second,second  | depart,turn left,arrive      | a,c,j     |
            | a,h       | first,first,first    | depart,continue uturn,arrive | a,c,h     |
            | e,j       | first,second,second  | depart,turn right,arrive     | e,f,j     |
            | e,h       | first,first          | depart,arrive                | e,h       |
            | e,l       | first,second,second  | depart,turn left,arrive      | e,g,l     |
            | e,d       | first,first,first    | depart,continue uturn,arrive | e,g,d     |
            | k,h       | second,first,first   | depart,turn right,arrive     | k,g,h     |
            | k,l       | second,second        | depart,arrive                | k,l       |
            | k,d       | second,first,first   | depart,turn left,arrive      | k,b,d     |
            | k,j       | second,second,second | depart,continue uturn,arrive | k,b,j     |
            | i,d       | second,first,first   | depart,turn right,arrive     | i,c,d     |
            | i,j       | second,second        | depart,arrive                | i,j       |
            | i,h       | second,first,first   | depart,turn left,arrive      | i,f,h     |
            | i,l       | second,second,second | depart,continue uturn,arrive | i,f,l     |

    Scenario: Segregated Intersection, Cross Belonging to Mixed Streets - Slight Angles (2)
        Given the node map
            """
                i l

                c b
            d   f g   a
            e         h
                j k
            """

        And the ways
            | nodes | highway | name   | oneway |
            | ab    | primary | first  | yes    |
            | bc    | primary | second | yes    |
            | cd    | primary | first  | yes    |
            | ef    | primary | first  | yes    |
            | fg    | primary | first  | yes    |
            | gh    | primary | first  | yes    |
            | ic    | primary | second | yes    |
            | bl    | primary | second | yes    |
            | kg    | primary | second | yes    |
            | fj    | primary | second | yes    |
            | cf    | primary | second | yes    |
            | gb    | primary | first  | yes    |

       When I route I should get
            | waypoints | route                | turns                        | locations |
            | a,l       | first,second,second  | depart,turn right,arrive     | a,b,l     |
            | a,d       | first,first          | depart,arrive                | a,d       |
            | a,j       | first,second,second  | depart,turn left,arrive      | a,c,j     |
            | a,h       | first,first,first    | depart,continue uturn,arrive | a,c,h     |
            | e,j       | first,second,second  | depart,turn right,arrive     | e,f,j     |
            | e,h       | first,first          | depart,arrive                | e,h       |
            | e,l       | first,second,second  | depart,turn left,arrive      | e,g,l     |
            | e,d       | first,first,first    | depart,continue uturn,arrive | e,g,d     |
            | k,h       | second,first,first   | depart,turn right,arrive     | k,g,h     |
            | k,l       | second,second        | depart,arrive                | k,l       |
            | k,d       | second,first,first   | depart,turn left,arrive      | k,b,d     |
            | k,j       | second,second,second | depart,continue uturn,arrive | k,b,j     |
            | i,d       | second,first,first   | depart,turn right,arrive     | i,c,d     |
            | i,j       | second,second        | depart,arrive                | i,j       |
            | i,h       | second,first,first   | depart,turn left,arrive      | i,f,h     |
            | i,l       | second,second,second | depart,continue uturn,arrive | i,f,l     |

    Scenario: Entering a segregated road
        Given the node map
            """
              a f       g
              | |   . '
              b-e '
              / /
             / /
            c d
            """

        And the ways
            | nodes | highway | name   | oneway |
            | abc   | primary | first  | yes    |
            | def   | primary | first  | yes    |
            | be    | primary | first  | no     |
            | ge    | primary | second | no     |

        When I route I should get
            | waypoints | route               | turns                          | locations |
            | d,c       | first,first,first   | depart,continue uturn,arrive   | d,e,c     |
            | a,f       | first,first,first   | depart,continue uturn,arrive   | a,b,f     |
            | a,g       | first,second,second | depart,turn left,arrive        | a,b,g     |
            | d,g       | first,second,second | depart,turn right,arrive       | d,e,g     |
            | g,f       | second,first,first  | depart,turn right,arrive       | g,e,f     |
            | g,c       | second,first,first  | depart,end of road left,arrive | g,b,c     |

    Scenario: Do not collapse turning roads
        Given the node map
            """
                e
                c---d
            a---b-f
            """

        And the ways
            | nodes | highway | name   | oneway |
            | ab    | primary | first  | yes    |
            | bc    | primary | first  | yes    |
            | cd    | primary | first  | yes    |
            | ce    | primary | second | yes    |
            | bf    | primary | third  | yes    |

        When I route I should get
            | waypoints | route                   | turns                                      | locations |
            | a,d       | first,first,first,first | depart,continue left,continue right,arrive | a,b,c,d   |
            | a,e       | first,second,second     | depart,turn left,arrive                    | a,b,e     |
            | a,f       | first,third,third       | depart,turn straight,arrive                | a,b,f     |

     Scenario: Bridge on unnamed road
        Given the node map
            """
            a b       c d
            """

        And the ways
            | nodes | highway | name   |
            | ab    | primary |        |
            | bc    | primary | Bridge |
            | cd    | primary |        |

        When I route I should get
            | waypoints | route | turns         |
            | a,d       | ,     | depart,arrive |

     Scenario: Crossing Bridge into Segregated Turn
        Given the node map
            """
                      f
            i-h-----g-e
            a-b-----c-d
            """

        And the ways
            | nodes | highway | oneway | name        |
            | ab    | primary | yes    | to_bridge   |
            | bc    | primary | yes    | bridge      |
            | cd    | primary | yes    | off_bridge  |
            | de    | primary | yes    |             |
            | ef    | primary | no     | target_road |
            | eg    | primary | yes    | off_bridge  |
            | gh    | primary | yes    | bridge      |
            | hi    | primary | yes    | to_bridge   |

        When I route I should get
            | waypoints | route                             | turns                   | locations |
            | a,f       | to_bridge,target_road,target_road | depart,turn left,arrive | a,d,f     |

    Scenario: Pankenbruecke
        Given the node map
            """
            k j
            | |
            | |
            | |
            a h
             b
             c
             d
             e
             f-i
             |
             |
             |
             |
             |
             |
             g
            """

        And the ways
            | nodes | highway | name    | oneway | lanes |
            | kabhj | primary | inroad  | yes    | 4     |
            | bc    | primary | inroad  | no     |       |
            | cd    | primary | bridge  | no     |       |
            | defg  | primary | outroad | no     |       |
            | fi    | primary | cross   | no     |       |

       When I route I should get
            | waypoints | route                  | turns                           | locations |
            | a,g       | inroad,outroad,outroad | depart,new name straight,arrive | a,d,g     |
            | a,i       | inroad,cross,cross     | depart,turn left,arrive         | a,f,i     |

     Scenario: Close Turns - Don't Collapse
        Given the node map
            """
              g d
              | |
            e-b-c-f
              | |
              a h
            """

        And the ways
            | nodes | highway | name     |
            | ab    | primary | in       |
            | ebcf  | primary | cross    |
            | cd    | primary | out      |
            | bg    | primary | straight |
            | ch    | primary | reverse  |

        When I route I should get
            | waypoints | route                    | turns                               | locations |
            | a,d       | in,cross,out,out         | depart,turn right,turn left,arrive  | a,b,c,d   |
            | a,h       | in,cross,reverse,reverse | depart,turn right,turn right,arrive | a,b,c,h   |
            | g,d       | straight,cross,out,out   | depart,turn left,turn left,arrive   | g,b,c,d   |

     Scenario: No Name During Turns
        Given the node map
            """
            a b
              c d
            """

        And the ways
            | nodes | highway  | name |
            | ab    | tertiary | road |
            | bc    | tertiary |      |
            | cd    | tertiary | road |

        When I route I should get
            | waypoints | route     | turns         |
            | a,d       | road,road | depart,arrive |

    Scenario: No Name During Turns - Ferry
        Given the node map
            """
            a b
              c d
            """

        And the ways
            | nodes | highway  | name | route |
            | ab    | tertiary | road |       |
            | bc    | tertiary |      | ferry |
            | cd    | tertiary | road |       |

        When I route I should get
            | waypoints | route           | turns                                              |
            | a,d       | road,,road,road | depart,notification right,notification left,arrive |

    Scenario: No Name During Turns, Random Oneway
        Given the node map
            """
            a b
              c d
            """

        And the ways
            | nodes | highway  | name | oneway |
            | ab    | tertiary | road | no     |
            | bc    | tertiary |      | yes    |
            | cd    | tertiary | road | no     |

        When I route I should get
            | waypoints | route     | turns         |
            | a,d       | road,road | depart,arrive |

    Scenario: No Name During Turns, keep important turns
        Given the node map
            """
            a b e
              c d
            """

        And the ways
            | nodes | highway  | name  |
            | ab    | tertiary | road  |
            | bc    | tertiary |       |
            | cd    | tertiary | road  |
            | be    | tertiary | other |

        When I route I should get
            | waypoints | route          | turns                        |
            | a,d       | road,road,road | depart,continue right,arrive |

    Scenario: Segregated Intersection into Slight Turn
        Given the node map
            """
            h
            a .
              ..
               .g
                b f
                | c .
                | | . ,
                | |  . .
                | |   . e
                | |     d
                j i
            """

        And the ways
            | nodes | highway   | name | oneway |
            | abcd  | primary   | road | yes    |
            | efgh  | primary   | road | yes    |
            | icf   | secondary | in   | yes    |
            | gbj   | secondary | out  | yes    |

        When I route I should get
            | waypoints | route        | turns                           | locations |
            | i,h       | in,road,road | depart,turn left,arrive         | i,f,h     |
            | a,d       | road,road    | depart,arrive                   | a,d       |
            | a,j       | road,out,out | depart,turn slight right,arrive | a,b,j     |

    Scenario: Segregated Intersection into Very Slight Turn
        Given the node map
            """
            h
            a.
             .,
              ..
               .g
                b.
                | f
                | c .
                | |. .
                | | . .
                | |  . .
                | |   . e
                | |     d
                j i
            """

        And the ways
            | nodes | highway   | name | oneway |
            | abcd  | primary   | road | yes    |
            | efgh  | primary   | road | yes    |
            | icf   | secondary | in   | yes    |
            | gbj   | secondary | out  | yes    |

        When I route I should get
            | waypoints | route        | turns                           | locations |
            | i,h       | in,road,road | depart,turn slight left,arrive  | i,f,h     |
            | a,d       | road,road    | depart,arrive                   | a,d       |
            | a,j       | road,out,out | depart,turn slight right,arrive | a,b,j     |

    Scenario: Don't collapse everything to u-turn / too wide
        Given the node map
            """
            a---b---e
                |
            d---c---f
            """

        And the ways
            | nodes | highway   | name   |
            | abcd  | primary   | road   |
            | be    | secondary | top    |
            | cf    | secondary | bottom |

        When I route I should get
            | waypoints | turns                                   | route               | locations |
            | a,d       | depart,continue right,turn right,arrive | road,road,road,road | a,b,c,d   |
            | d,a       | depart,continue left,turn left,arrive   | road,road,road,road | d,c,b,a   |

    Scenario: Forking before a turn
        Given the node map
            """
                  g
                  |
                 .c
            a---b-d-e
                  |
                  f
            """

        And the ways
            | nodes | name  | oneway | highway   |
            | ab    | road  | yes    | primary   |
            | bd    | road  | yes    | primary   |
            | bc    | road  | yes    | primary   |
            | de    | road  | yes    | primary   |
            | fd    | cross | no     | secondary |
            | dc    | cross | no     | secondary |
            | cg    | cross | no     | secondary |

        And the relations
            | type        | way:from | way:to | node:via | restriction   |
            | restriction | bd       | dc     | d        | no_left_turn  |
            | restriction | bc       | dc     | c        | no_right_turn |

        When I route I should get
          | waypoints | route            | turns                   | locations |
          | a,g       | road,cross,cross | depart,turn left,arrive | a,b,g     |
          | a,e       | road,road        | depart,arrive           | a,e       |

    Scenario: Forking before a turn (narrow)
        Given the node map
            """
                  g
                  |
                ..c
            a-b---d-e
                  |
                  f
            """

        And the ways
            | nodes | name  | oneway | highway   |
            | ab    | road  | yes    | primary   |
            | bd    | road  | yes    | primary   |
            | bc    | road  | yes    | primary   |
            | de    | road  | yes    | primary   |
            | fd    | cross | no     | secondary |
            | dc    | cross | no     | secondary |
            | cg    | cross | no     | secondary |

        And the relations
            | type        | way:from | way:to | node:via | restriction   |
            | restriction | bd       | dc     | d        | no_left_turn  |
            | restriction | bc       | dc     | c        | no_right_turn |

        When I route I should get
            | waypoints | route            | turns                   | locations |
            | a,g       | road,cross,cross | depart,turn left,arrive | a,b,g     |
            | a,e       | road,road        | depart,arrive           | a,e       |

    Scenario: Forking before a turn (forky)
        Given the node map
            """
                      g
                      .
                      c
            a . . b .'
                      ` d.
                        f e
            """
            # as it is right now we don't classify this as a sliproad,
            # check collapse-detail.feature for a similar test case
            # which removes the fork here due to it being a Sliproad.

        And the ways
            | nodes | name  | oneway | highway   |
            | ab    | road  | yes    | primary   |
            | bd    | road  | yes    | primary   |
            | bc    | road  | yes    | primary   |
            | de    | road  | yes    | primary   |
            | fd    | cross | no     | secondary |
            | dc    | cross | no     | secondary |
            | cg    | cross | no     | secondary |

        And the relations
            | type        | way:from | way:to | node:via | restriction   |
            | restriction | bd       | dc     | d        | no_left_turn  |
            | restriction | bc       | dc     | c        | no_right_turn |

        When I route I should get
            | waypoints | route                 | turns                                      | locations |
            | a,g       | road,cross,cross      | depart,fork slight left,arrive             | a,b,g     |
            | a,e       | road,road,road        | depart,fork slight right,arrive            | a,b,e     |
            | a,f       | road,road,cross,cross | depart,fork slight right,turn right,arrive | a,b,d,f   |

    Scenario: On-Off on Highway
        Given the node map
            """
            f
            a b c d
                  e
            """

        And the ways
            | nodes | name | highway       | oneway |
            | abcd  | Hwy  | motorway      | yes    |
            | fb    | on   | motorway_link | yes    |
            | ce    | off  | motorway_link | yes    |

        When I route I should get
            | waypoints | route          | turns                                           | locations |
            | a,d       | Hwy,Hwy        | depart,arrive                                   | a,d       |
            | f,d       | on,Hwy,Hwy     | depart,merge slight right,arrive                | f,b,d     |
            | f,e       | on,Hwy,off,off | depart,merge slight right,off ramp right,arrive | f,b,c,e   |
            | a,e       | Hwy,off,off    | depart,off ramp right,arrive                    | a,c,e     |

    @negative @straight
    Scenario: Don't collapse going straight if actual turn
        Given the node map
            """
                e
             c  |
              \ d - - - f
               \|
                b
                |
                |
                a
            """

        And the ways
            | nodes | name     | highway     |
            | abc   | main     | primary     |
            | bde   | straight | residential |
            | df    | right    | residential |

        When I route I should get
            | waypoints | route                     | turns                                  | locations |
            | a,c       | main,main                 | depart,arrive                          | a,c       |
            | a,e       | main,straight,straight    | depart,turn straight,arrive            | a,b,e     |
            | a,f       | main,straight,right,right | depart,turn straight,turn right,arrive | a,b,d,f   |

    Scenario: Entering a segregated road
        Given the node map
            """
              a f
                    g
              b e


            c d
            """

        And the ways
            | nodes | highway | name   | oneway |
            | abc   | primary | first  | yes    |
            | def   | primary | first  | yes    |
            | be    | primary | first  | no     |
            | ge    | primary | second | no     |

        When I route I should get
            | waypoints | route               | turns                          | locations |
            | d,c       | first,first,first   | depart,continue uturn,arrive   | d,e,c     |

    Scenario: Entering a segregated road slight turn
        Given the node map
            """
                a f
                    g
              b e


            c d
            """

        And the ways
            | nodes | highway | name   | oneway |
            | abc   | primary | first  | yes    |
            | def   | primary | first  | yes    |
            | be    | primary | first  | no     |
            | ge    | primary | second | no     |

        When I route I should get
            | waypoints | route               | turns                          | locations |
            | d,c       | first,first,first   | depart,continue uturn,arrive   | d,e,c     |

    Scenario: Do not collapse UseLane step when lanes change
        Given the node map
            """
                  f g

            a b c d   e

                  h i
            """

        And the ways
            | nodes | turn:lanes:forward                     | name |
            | ab    |                                        | main |
            | bc    | left\|through\|through\|through\|right | main |
            | cd    | left\|through\|right                   | main |
            | de    |                                        | main |
            | cf    |                                        | off  |
            | ch    |                                        | off  |
            | dg    |                                        | off  |
            | di    |                                        | off  |

       When I route I should get
            | waypoints | route          | turns                           | locations |
            | a,e       | main,main,main | depart,use lane straight,arrive | a,c,e     |

    Scenario: But _do_ collapse UseLane step when lanes stay the same
        Given the node map
            """
                  f g

            a b c d   e

                  h i
            """

        And the ways
            | nodes | turn:lanes:forward                     | name |
            | ab    |                                        | main |
            | bc    | left\|through\|through\|through\|right | main |
            | cd    | left\|through\|through\|through\|right | main |
            | de    |                                        | main |
            | cf    |                                        | off  |
            | ch    |                                        | off  |
            | dg    |                                        | off  |
            | di    |                                        | off  |

       When I route I should get
            | waypoints | route     | turns         |
            | a,e       | main,main | depart,arrive |

    Scenario: Don't collapse different travel modes
        Given the node map
            """
            g             h
            a b   c       e f
                      d
                  i j
            """

        And the ways
            | nodes | highway | route | name |
            | ab    | primary |       | road |
            | bc    | primary | ferry |      |
            | cd    | primary |       | road |
            | de    |         | ferry |      |
            | ef    | primary |       | road |
            | bg    | service |       | turn |
            | ci    | service |       | turn |
            | dj    | service |       | turn |
            | eh    | service |       | turn |

        When I route I should get
            | waypoints | route                 |
            | a,f       | road,,road,,road,road |

    Scenario: U-Turn onto a Ferry
        Given the node map
            """
                        i
            j e ~ ~ ~ ~ d c h
                          |
                          |
            k g ~ ~ ~ ~ a b f
            """

        And the ways
            | nodes | highway | route | name  | oneway |
            | abf   | primary |       | road  | yes    |
            | hcd   | primary |       | road  | yes    |
            | bc    | primary |       |       | yes    |
            | di    | service |       | serv  | yes    |
            | ed    |         | ferry | ferry |        |
            | ga    |         | ferry | ferry |        |
            | kg    | primary |       | on    | yes    |
            | ej    | primary |       | off   | yes    |

        When I route I should get
            | waypoints | route                            | turns                                                                                                        | locations     |
            | k,j       | on,ferry,road,road,ferry,off,off | depart,notification straight,notification straight,continue uturn,turn straight,notification straight,arrive | k,g,a,b,d,e,j |

    # http://www.openstreetmap.org/#map=19/37.78090/-122.41251
    Scenario: U-Turn onto unnamed-road
        Given the node map
            """
            d . _           h
                  ' b . _   |
                    |     ' e   g
                    |       f '
                    |   1 '
                    a '
            """

        And the ways
            | nodes | highway   | turn:lanes     | name  | oneway |
            | ab    | secondary |                | up    | yes    |
            | gfa   | secondary |                |       | yes    |
            | dbe   | tertiary  |                | turn  | no     |
            | he    | secondary | through\|right | down  | yes    |
            | ef    | secondary |                | down  | yes    |

        When I route I should get
            | waypoints | route         | turns                               | locations |
            | a,1       | up,turn,down, | depart,turn right,turn right,arrive | a,b,e,_   |

    #http://www.openstreetmap.org/#map=19/52.48778/13.30024
    Scenario: Hohenzollerdammbrücke
        Given a grid size of 10 meters
        Given the node map
            """
                  q          s
                  p          o
                  ..        ..
                 .    .   .    .
            j - i - - - h - - - g - f
                  > k <   > l <
            a - b - - - c - - - d - e
                 .    .  .     .
                  ..        ..
                  m          n
                  t          r
            """

        And the ways
            | nodes | highway       | name        | oneway |
            | ab    | secondary     | hohe        | yes    |
            | bc    | secondary     | hohebruecke | yes    |
            | cd    | secondary     | hohebruecke | yes    |
            | bk    | secondary     | hohebruecke | yes    |
            | kh    | secondary     | hohebruecke | yes    |
            | ki    | secondary     | hohebruecke | yes    |
            | ck    | secondary     | hohebruecke | yes    |
            | de    | secondary     | hohe        | yes    |
            | fg    | secondary     | hohe        | yes    |
            | gh    | secondary     | hohebruecke | yes    |
            | hi    | secondary     | hohebruecke | yes    |
            | gl    | secondary     | hohebruecke | yes    |
            | lc    | secondary     | hohebruecke | yes    |
            | hl    | secondary     | hohebruecke | yes    |
            | ld    | secondary     | hohebruecke | yes    |
            | ij    | secondary     | hohe        | yes    |
            | bm    | motorway_link | a100        | yes    |
            | cm    | motorway_link | a100        | yes    |
            | nc    | motorway_link | a100        | yes    |
            | nd    | motorway_link | a100        | yes    |
            | go    | motorway_link | a100        | yes    |
            | ho    | motorway_link | a100        | yes    |
            | ph    | motorway_link | a100        | yes    |
            | pi    | motorway_link | a100        | yes    |
            | qp    | motorway_link | a100        | yes    |
            | mt    | motorway_link | a100        | yes    |
            | rn    | motorway_link | a100        | yes    |
            | os    | motorway_link | a100        | yes    |

        And the relations
            | type        | way:from | way:to | node:via | restriction   |
            | restriction | ck       | kh     | k        | no_right_turn |
            | restriction | bk       | ki     | k        | no_left_turn  |
            | restriction | hl       | lc     | l        | no_right_turn |
            | restriction | gl       | ld     | l        | no_left_turn  |
            | restriction | bc       | cm     | c        | no_right_turn |
            | restriction | bc       | ck     | c        | no_left_turn  |
            | restriction | nc       | cm     | c        | no_left_turn  |
            | restriction | nc       | cd     | c        | no_right_turn |
            | restriction | lc       | ck     | c        | no_left_turn  |
            | restriction | lc       | cd     | c        | no_right_turn |
            | restriction | gh       | ho     | h        | no_right_turn |
            | restriction | gh       | hl     | h        | no_left_turn  |
            | restriction | kh       | hi     | h        | no_left_turn  |
            | restriction | kh       | hl     | h        | no_right_turn |
            | restriction | ph       | ho     | h        | no_left_turn  |
            | restriction | ph       | hi     | h        | no_right_turn |

        When I route I should get
            | waypoints | route                 | turns                       | locations |
            | a,e       | hohe,hohe             | depart,arrive               | a,e       |
            | a,s       | hohe,a100,a100        | depart,on ramp left,arrive  | a,b,s     |
            | a,t       | hohe,a100,a100        | depart,on ramp right,arrive | a,b,t     |
            | a,j       |                       |                             |           |
            | f,j       | hohe,hohe             | depart,arrive               | f,j       |
            | a,t       | hohe,a100,a100        | depart,on ramp right,arrive | a,b,t     |
            | f,e       |                       |                             |           |
            | q,j       | a100,hohe,hohe        | depart,turn right,arrive    | q,p,j     |
            | q,e       | a100,hohebruecke,hohe | depart,turn left,arrive     | q,p,e     |
