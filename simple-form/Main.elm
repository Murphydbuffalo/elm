import Html exposing (Html, div, button, input, text)
import Html.Attributes exposing (placeholder, style, type')
import Html.Events exposing (onInput, onClick)
import Html.App as App
import Regex
import String
import Char

main : Program Never
main = App.beginnerProgram { model = model , view = view , update = update }

type alias Model = {
  email : String,
  password : String,
  passwordConfirmation : String,
  valid : Bool,
  errors : String
}

model : Model
model = {
  email = "",
  password = "",
  passwordConfirmation = "",
  valid = False,
  errors = ""
 }

type Msg = Email String | Password String | PasswordConfirmation String | Submit

update : Msg -> Model -> Model
update msg model =
  case msg of
    Email email ->
      { model | email = email }
    Password password ->
      { model | password = password }
    PasswordConfirmation passwordConfirmation ->
      { model | passwordConfirmation = passwordConfirmation }
    Submit ->
      let
        (valid, errors) =
          isValid model

        updatedModel =
          { model | valid = valid, errors = errors }
      in
        attemptSubmit updatedModel

view : Model -> Html Msg
view model =
  div [] [
    input [type' "email", placeholder "Email", onInput Email] [],
    input [type' "password", placeholder "Password", onInput Password] [],
    input [type' "password", placeholder "Password Confirmation", onInput PasswordConfirmation] [],
    div [] [
      button [type' "submit", onClick Submit] [text "Submit"],
      div [style [("color", "red")]] [text model.errors]
    ]
  ]

isValid : Model -> (Bool, String)
isValid model =
  let
    emailIsValid : Bool
    emailIsValid = validEmail model.email

    passwordIsValid : Bool
    passwordIsValid = validPassword model.password

    passwordsMatch : Bool
    passwordsMatch = model.password == model.passwordConfirmation

    valid : Bool
    valid = emailIsValid && passwordIsValid && passwordsMatch

    emailErrorMessage : String
    emailErrorMessage =
      if not emailIsValid then
        "Please enter a valid email. "
      else
        ""

    passwordErrorMessage : String
    passwordErrorMessage =
      if not passwordIsValid then
        "Please enter a valid password. "
      else
        ""

    passwordMatchErrorMessage : String
    passwordMatchErrorMessage =
      if not passwordsMatch then
        "Please enter a matching password and password confirmation. "
      else
        ""

    errors : String
    errors = emailErrorMessage ++ passwordErrorMessage ++ passwordMatchErrorMessage
  in
    (valid, errors)

validEmail : String -> Bool
validEmail email =
  let
    regex =
      Regex.regex ".+@.+\\..+"
  in
    Regex.contains regex email

validPassword : String -> Bool
validPassword password =
  String.length password > 7 &&
  String.any Char.isDigit password &&
  String.any Char.isUpper password &&
  String.any Char.isLower password

attemptSubmit : Model -> Model
attemptSubmit model =
  -- if model.valid then
    -- Make HTTP call
    -- Clear form

  model
