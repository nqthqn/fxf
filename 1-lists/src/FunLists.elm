module FunLists exposing (..)


data =
    [ { name = "Hat", price = 5.0 }
    , { name = "Boots", price = 10.0 }
    , { name = "Jacket", price = 15.0 }
    , { name = "Mandolin", price = 50.0 }
    , { name = "Pen", price = 2.5 }
    , { name = "Grandfather clock", price = 100.0 }
    ]


type alias Item =
    { name : String, price : Float }


euros : List Item -> List Item
euros =
    List.map (\item -> { item | price = item.price * 0.85 })


cheap : List Item -> List Item
cheap =
    List.filter (\item -> item.price <= 10)


priciest : List Item -> Item
priciest =
    List.foldl costly { name = "", price = 0 }


costly : Item -> Item -> Item
costly i1 i2 =
    if i1.price > i2.price then
        i1
    else
        i2



{-
   spec:
     - See price in Euros (map)
     - See items that are $10 or less (filter)
     - See highest cost item (maximum reimplemented w/ foldl)
-}
