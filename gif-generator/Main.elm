import Html exposing (Html, h1, div, text, button, img, br)
import Html.App as App
import Html.Attributes exposing (src, alt)
import Html.Events exposing (onClick)
import Http
import Json.Decode as Json
import Task

main : Program Never
main =
  App.program {
    init = init,
    view = view,
    update = update,
    subscriptions = subscriptions
  }

type alias Model = {
  category : String,
  url : String
}

init : (Model, Cmd Msg)
init =
  (Model "doge" "http://i.imgur.com/MTiOtUC.gif", Cmd.none)

type Msg = NewGif | HttpSuccess String | HttpFailure Http.Error

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    NewGif ->
      (model, fetchGif model.category)
    HttpSuccess newUrl ->
      (Model model.category newUrl, Cmd.none)
    HttpFailure _ ->
      (model, Cmd.none)

fetchGif : String -> Cmd Msg
fetchGif category =
  let
    url =
      "https://api.giphy.com/v1/gifs/random?api_key=dc6zaTOxFJmzC&tag=" ++ category
  in
    Task.perform HttpFailure HttpSuccess (Http.get decodeUrl url)

decodeUrl : Json.Decoder String
decodeUrl =
  Json.at ["data", "image_url"] Json.string


view : Model -> Html Msg
view model =
  div [] [
    h1 [] [text model.category],
    img [src model.url, alt "A doge GIF"] [],
    br [] [],
    button [onClick NewGif] [text "New GIF!"]
  ]

subscriptions : Model -> Sub Msg
subscriptions model =
  Sub.none
