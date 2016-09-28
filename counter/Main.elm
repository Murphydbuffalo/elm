import Html exposing (Html, div, button, text)

-- Modules namespaced within Html
import Html.App as App
import Html.Events exposing (onClick)

-- A type declaration saying "the variable `main` is of type `Program`"
main : Program Never
main = App.beginnerProgram { model = model , view = view , update = update }

-- An alias type saying the type `Model` is another name for the type `Int`
type alias Model = Int

model : Model
model = 0

-- A union type saying declaring the type `Msg` as valid for any of values provided
type Msg = Increment | Decrement | Reset

-- This is the syntax for a type declaration specifying a function, its arguments, and return value
-- It says "update is a function that takes `Msg` and `Model` types as arguments"
-- and returns a `Model` type
-- IMPORTANT: `update` is a special function that is automatically invoked whenever
-- a new `Msg` type is return (as is the case in our `view` function below)
update : Msg -> Model -> Model
update msg model =
  case msg of
    Increment ->
      model + 1
    Decrement ->
      model - 1
    Reset ->
      0

-- `view` takes a `Model` and returns `Html`, which itself can return `Msg` values
-- The `onClick` functions return those `Msg` values and thus invoke `update`.
-- The `view` function is analogous to React.js's `render` function. It expresses
-- your UI as a function that is populated with your application's state/data.
-- Elm will intelligently compute the most efficient way to re-render the UI
-- whenever the `view` function is called, making Elm apps lickedy split.
view : Model -> Html Msg
view model =
  div [] [
    button [onClick Increment] [text "+"],
    button [onClick Decrement] [text "-"],
    div [] [text (toString model)],
    button [onClick Reset] [text "Reset!"]
  ]
