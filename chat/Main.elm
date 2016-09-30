import Html exposing (Html, div, button, input, text)
import Html.Attributes exposing (type', placeholder)
import Html.App as App
import Html.Events exposing (onClick, onInput)
import WebSocket

main : Program Never
main =
  App.program {
    init = init,
    update = update,
    view = view,
    subscriptions = subscriptions
  }

type alias Model = { input : String, messages : List String }
type Msg = Input String | SendMessage | ReceiveMessage String

init : (Model, Cmd Msg)
init = ({ input = "", messages = [] }, Cmd.none)

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    Input newInput ->
      ({ model | input = newInput }, Cmd.none)
    SendMessage ->
      ({ model | input = "" }, WebSocket.send "ws://echo.websocket.org" model.input)
    ReceiveMessage receivedMessage ->
      ({ model | messages = (receivedMessage :: model.messages) }, Cmd.none)

subscriptions : Model -> (Sub Msg)
subscriptions model =
  WebSocket.listen "ws://echo.websocket.org" ReceiveMessage

view : Model -> Html Msg
view model =
  div [] [
    div [] (List.map messageDiv model.messages),
    div [] [
      input [type' "text", placeholder "Type here", onInput Input] [text model.input],
      button [type' "submit", onClick SendMessage] [text "Send"]
    ]
  ]

messageDiv : String -> Html Msg
messageDiv message =
  div [] [text message]
