import Html exposing (Html, input, div, text)
import Html.App as App
import Html.Attributes exposing (placeholder)
import Html.Events exposing (onInput)
import String

main = App.beginnerProgram { model = model, update = update, view = view }

-- MODEL

type alias Model = String
model : Model
model = ""

-- UPDATE

type Msg = Change String
update : Msg -> Model -> Model
update msg model =
  case msg of
    Change string ->
      string

-- VIEW

view : Model -> Html Msg
view model =
  div [] [
    input [placeholder "A man a plan a canal Panama", onInput Change] [],
    div [] [text ( String.reverse model)]

  ]
