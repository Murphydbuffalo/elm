import Html exposing (Html)
import Html.App as App
import Svg exposing (..)
import Svg.Attributes exposing (..)
import Time exposing (Time, second)

main : Program Never
main =
  App.program {
    init = init,
    update = update,
    subscriptions = subscriptions,
    view = view
  }

type alias Model = Time
type Msg = Tick Time

init : (Model, Cmd Msg)
init = (0, Cmd.none)

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    Tick time ->
      (time, Cmd.none)

subscriptions : Model -> Sub Msg
subscriptions model =
  -- Every second, get the time in milliseconds
  Time.every second Tick

view : Model -> Html Msg
view model =
  let
    angle =
      -- `turns` converts floats to radians. 1.0 is equivalent to 360 degrees
      -- Time.inMinutes converts milliseconds to minutes represented as a as a float
      turns (Time.inMinutes model)
    handX =
      toString (50 + (40 * cos angle))
    handY =
      toString (50 + (40 * sin angle))
  in
    svg [viewBox "0 0 100 100", width "300px"] [
      circle [cx "50", cy "50", r "45", fill "#0B79CE"] [],
      line [x1 "50", y1 "50", x2 handX, y2 handY, stroke "#023963"] []
    ]
