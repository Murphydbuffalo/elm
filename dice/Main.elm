import Html exposing (Html, h1, div, text, input)
import Html.Attributes exposing (type')
import Html.Events exposing (onClick)
import Html.App as App
import Random

main : Program Never
main =
  App.program {
    init = init,
    view = view,
    update = update,
    subscriptions = subscriptions
  }

type alias Model = {
  value : Int
}

init : (Model, Cmd Msg)
init =
  (Model 1, Cmd.none)

type Msg = Roll | NewVal Int

view : Model -> Html Msg
view model =
  div [] [
    h1 [] [text (toString model.value)],
    input [type' "submit", onClick Roll] [text "Roll!"]
  ]

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    Roll ->
      (model, Random.generate NewVal (Random.int 1 6))
    NewVal val ->
      (Model val, Cmd.none)

subscriptions : Model -> Sub Msg
subscriptions model =
  Sub.none
