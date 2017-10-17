module FunLists exposing (..)


data =
    [ { name = "Hat", price = 5.0 }
    , { name = "Boots", price = 10.0 }
    , { name = "Jacket", price = 15.0 }
    , { name = "Mandolin", price = 50.0 }
    , { name = "Pen", price = 2.5 }
    , { name = "Grandfather clock", price = 100.0 }
    ]


euros =
    []


cheap =
    []


priciest =
    []


priceyItem i1 i2 =
    []



{-
   spec:
     - See price in Euros (map)
     - See items that are $10 or less (filter)
     - See highest cost item (maximum reimplemented w/ foldl)
-}
