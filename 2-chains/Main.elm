module Main exposing (..)

import Html exposing (..)
import Http
import Task exposing (Task)
import Json.Decode as JD


-- getPersonsCake personId =


getCake : String -> Task Http.Error Cake
getCake id =
    Http.get (api ++ "/cake/" ++ id) cakeDecoder
        |> Http.toTask


getPerson : String -> Task Http.Error Person
getPerson id =
    Http.get (api ++ "/person/" ++ id) personDecoder
        |> Http.toTask


getPersonsCake : String -> Task Http.Error Cake
getPersonsCake personId =
    getPerson personId
        |> Task.andThen (\person -> getCake (toString person.cake_id))


api : String
api =
    "http://127.0.0.1:3000"


personsDecoder : JD.Decoder (List Person)
personsDecoder =
    JD.list personDecoder


personDecoder : JD.Decoder Person
personDecoder =
    JD.map3 Person
        (JD.field "id" JD.int)
        (JD.field "name" JD.string)
        (JD.field "cake_id" JD.int)


cakesDecoder : JD.Decoder (List Cake)
cakesDecoder =
    JD.list cakeDecoder


cakeDecoder : JD.Decoder Cake
cakeDecoder =
    JD.map3 Cake
        (JD.field "id" JD.int)
        (JD.field "name" JD.string)
        (JD.succeed [])


type alias Model =
    { error : String
    , cakes : List Cake
    }


type alias Cake =
    { id : Int
    , name : String
    , eaters : List Person
    }


type alias Person =
    { id : Int
    , name : String
    , cake_id : Int
    }


initModel : Model
initModel =
    { error = ""
    , cakes = []
    }


type Msg
    = CakeResp (Result Http.Error Cake)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        CakeResp (Ok cake) ->
            ( { model | cakes = cake :: model.cakes }, Cmd.none )

        CakeResp (Err _) ->
            ( { model | error = "Cake related error." }, Cmd.none )


view : Model -> Html Msg
view model =
    toString model
        |> text


initCmd : Cmd Msg
initCmd =
    Task.attempt CakeResp (getPersonsCake "1")


main =
    program
        { init = ( initModel, initCmd )
        , update = update
        , subscriptions = always Sub.none
        , view = view
        }
