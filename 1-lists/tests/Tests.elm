module Tests exposing (..)

import Test exposing (..)
import Expect
import Fuzz exposing (list, int, tuple, string)
import String
import FunLists exposing (data)


all : Test
all =
    describe "Testing is fun"
        [ describe "Unit test examples"
            [ test "euros" <|
                \() ->
                    Expect.equal (FunLists.euros data) euroData
            , test "cheap" <|
                \() ->
                    Expect.equal (FunLists.cheap data) cheapData
            , test "priciest" <|
                \() ->
                    Expect.equal (FunLists.priciest data) priciestData
            ]
        ]


euroData =
    [ { name = "Hat", price = 4.25 }
    , { name = "Boots", price = 8.5 }
    , { name = "Jacket", price = 12.75 }
    , { name = "Mandolin", price = 42.5 }
    , { name = "Pen", price = 2.125 }
    , { name = "Grandfather clock", price = 85 }
    ]


cheapData =
    [ { name = "Hat", price = 5.0 }
    , { name = "Boots", price = 10.0 }
    , { name = "Pen", price = 2.5 }
    ]


priciestData =
    { name = "Grandfather clock", price = 100.0 }
