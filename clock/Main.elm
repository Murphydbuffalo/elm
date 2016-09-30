import Html exposing (Html, div, button, text)
import Html.Events exposing (onClick)
import Html.App as App
import Svg exposing (svg, circle, line)
import Svg.Attributes exposing (fill, stroke, viewBox, width, x1, x2, y1, y2, r, cx, cy)
import Time exposing (Time, second)

main : Program Never
main =
  App.program {
    init = init,
    update = update,
    subscriptions = subscriptions,
    view = view
  }

type alias Model = { time : Float, paused : Bool }
type Msg = Tick Time | Pause

init : (Model, Cmd Msg)
init = ({ time = 0, paused = False }, Cmd.none)

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    Tick time ->
      if model.paused then
        (model, Cmd.none)
      else
        ({ model | time = model.time + 1 }, Cmd.none)
    Pause ->
      ({ model | paused = not model.paused }, Cmd.none)

subscriptions : Model -> Sub Msg
subscriptions model =
  -- Every second, get the time in milliseconds and pass it to the Tick function
  Time.every second Tick

view : Model -> Html Msg
view model =
  let
    angle =
      -- `turns` converts floats to radians. 1.0 is equivalent to 360 degrees and 2pi or 6.28 radians
      -- So, every minute (60/60) `angle` will have increased by another 360 degrees
      turns (model.time / 60)
    handX =
      toString (50 + (40 * cos angle))
    handY =
      toString (50 + (40 * sin angle))
  in
    div [] [
      svg [viewBox "0 0 100 100", width "300px"] [
        circle [cx "50", cy "50", r "45", fill "#0B79CE"] [],
        line [x1 "50", y1 "50", x2 handX, y2 handY, stroke "#023963"] []
      ],
      button [onClick Pause] [text "Pause"]
    ]
