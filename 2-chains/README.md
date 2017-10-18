
 elm-reactor
 node server.js

Task
attempt : (Result x a -> msg) -> Task x a -> Cmd msg
andThen : (a -> Task x b) -> Task x a -> Task x b

Http
toTask : Request a -> Task Error a