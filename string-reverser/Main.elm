import Html exposing (Html, div, input, text)
import Html.Events exposing (onInput)
import Html.Attributes exposing (placeholder)
import Html.App as App
import String

main : Program Never
main = App.beginnerProgram { model = model, view = view , update = update }

type alias Model = { text : String }

model : Model
model = { text = "" }

-- This declares `Change` as a function that returns a `String`
type Msg = Change String

update : Msg -> Model -> Model
update msg model =
  case msg of
    Change newText ->
      { model | text = String.reverse newText }

-- `view` takes a `Model` and returns an `Html` function, which in turn can return a `Msg`
view : Model -> Html Msg
view model =
  div [] [
    -- `onInput` takes the `Change` function type as an argument, and passes the
    -- actual content of the `input` field as the `String` argument to `Change`
    input [placeholder "Type something!", onInput Change] [],
    div [] [text (toString model.text)]
  ]
