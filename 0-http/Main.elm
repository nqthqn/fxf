module Main exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Http
import Json.Decode as JD
import Json.Encode as JE


api =
    "http://127.0.0.1:5000/"


getNotes : Http.Request (List Note)
getNotes =
    Http.get api notesDecoder


notesDecoder : JD.Decoder (List Note)
notesDecoder =
    JD.list noteDecoder


noteDecoder : JD.Decoder Note
noteDecoder =
    JD.map3 Note
        (JD.field "url" JD.string)
        (JD.field "text" JD.string)
        (JD.field "stars" JD.int)


postNote : String -> Int -> Http.Request Note
postNote ntext stars =
    Http.post api (Http.jsonBody (noteEncoder ntext stars)) noteDecoder


noteEncoder : String -> Int -> JE.Value
noteEncoder ntext stars =
    JE.object
        [ ( "text", JE.string ntext )
        , ( "stars", JE.int stars )
        ]



-- Model


type alias Model =
    { notes : List Note
    , noteText : String
    , error : String
    }


type alias Note =
    { url : String
    , text : String
    , stars : Int
    }



-- Update


type Msg
    = SetNote String
    | AddNote
    | NotesResp (Result Http.Error (List Note))
    | NoteResp (Result Http.Error Note)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        SetNote noteText ->
            ( { model | noteText = noteText }, Cmd.none )

        AddNote ->
            ( { model | noteText = "" }
            , Http.send NoteResp (postNote model.noteText 0)
            )

        NotesResp (Ok notes) ->
            ( { model | notes = notes }, Cmd.none )

        NotesResp (Err error) ->
            ( { model | error = toString error }, Cmd.none )

        NoteResp (Ok note) ->
            ( { model | notes = note :: model.notes }, Cmd.none )

        NoteResp (Err error) ->
            ( { model | error = toString error }, Cmd.none )



--View


view : Model -> Html Msg
view model =
    div []
        [ ul []
            (List.map
                (\n ->
                    li []
                        [ text n.text
                        , text " "
                        , strong [] [ text <| toString n.stars ]
                        ]
                )
                model.notes
            )
        , div []
            [ input [ type_ "text", value model.noteText, onInput SetNote ] []
            , button [ onClick AddNote ] [ text "Add" ]
            ]
        , text model.error
        ]


initCmd : Cmd Msg
initCmd =
    Http.send NotesResp getNotes


initModel : Model
initModel =
    { notes = []
    , noteText = ""
    , error = ""
    }


main : Program Never Model Msg
main =
    program
        { update = update
        , view = view
        , init = ( initModel, initCmd )
        , subscriptions = always Sub.none
        }
