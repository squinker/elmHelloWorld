module Main2 exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Http exposing (..)

main =
    Html.beginnerProgram { model = model, view = view, update = update }

type alias Model =
        { entries : List String
        , results : List String
        , filter : String
        }

model : Model
model =
    { entries = []
    , results = []
    , filter = ""
    }

fnordUrl = "http://discovery.hubsvc.itv.com/platform/itvonline/mobile/productions?features=hls,aes,fairplay,inband-webvtt,fairplay-download&broadcaster=itv&programmeId=2_3697"

put : String -> Body -> Request ()
put url body =
      request
        { method = "GET"
        , headers = [Http.header "Accept" "application/vnd.itv.hubsvc.production.v3.hal.json" ]
        , url = url
        , body = body
        , expect = expectStringResponse (\_ -> Ok ())
        , timeout = Nothing
        , withCredentials = False
        }


type Msg = GetFnordApiResult (Result Http.Error String)



--Clickign 'Add' should send a request to fnord


update : Msg -> Model -> Model
update msg model =
    case msg of


        GetFnordApiResult (Ok book) ->
            { model
                | entries = model.filter :: model.entries
                , results = model.filter :: model.results
            }

view : Model -> Html Msg
view model =
    div []
        [ button [ onClick GetFnordApiResult ] [ text "Send request to " ]]

viewEntry : String -> Html Msg
viewEntry entry =
    li [] [ text entry ]


