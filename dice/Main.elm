import Html exposing (Html, h1, div, text, button)
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
  dieFace : Int
}

type Msg = Roll | NewDieFace Int

init : (Model, Cmd Msg)
init =
  (Model 1, Cmd.none)

subscriptions : Model -> (Sub Msg)
subscriptions model =
  Sub.none

view : Model -> Html Msg
view model =
  div [] [
    h1 [] [text (toString model.dieFace)],
    button [onClick Roll] [text "Roll"]
  ]

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    Roll ->
      (model, Random.generate NewDieFace (Random.int 1 6))
    NewDieFace randomNumber ->
      (Model randomNumber, Cmd.none)
