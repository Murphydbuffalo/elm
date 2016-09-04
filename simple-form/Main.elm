import Html exposing (Html, input, div, text, button)
import Html.App as App
import Html.Attributes exposing (placeholder, style, type')
import Html.Events exposing (onInput, onSubmit)
import String

main = App.beginnerProgram { model = model, update = update, view = view }

-- MODEL (the state of the application)

type alias Model = {
  email : String,
  password : String,
  passwordConfirmation : String
}

model : Model
model = Model "" "" ""

-- UPDATE (how the state should be mutated)

type Msg =
  Email String |
  Password String |
  PasswordConfirmation String

update : Msg -> Model -> Model
update msg model =
  case msg of
    Email email ->
      { model | email = email }

    Password password ->
      { model | password = password }

    PasswordConfirmation passwordConfirmation ->
      { model | passwordConfirmation = passwordConfirmation }


-- VIEW

view : Model -> Html Msg
view model =
  div [] [
    input [type' "email", placeholder "Email", onInput Email] [],
    input [type' "password", placeholder "Password", onInput Password] [],
    input [type' "password", placeholder "Confirm Password", onInput PasswordConfirmation] [],
    button [type' "submit"] [text "Submit"],
    validateInput model
  ]

validateInput : Model -> Html msg
validateInput model =
  let
    (color, message) =
      if model.password == model.passwordConfirmation && String.contains "@" model.email
      then ("green", "You're all set!")
      else ("red", "Make sure your passwords match and you have entered a valid email!")
  in
    div [style [("color", color)]] [text message]
