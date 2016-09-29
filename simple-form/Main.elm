import Html exposing (Html, div, button, input, text)
import Html.Attributes exposing (placeholder, style, type', class, id)
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
  errors : { email : List String, password : List String, passwordConfirmation : List String }
}

model : Model
model = {
  email = "",
  password = "",
  passwordConfirmation = "",
  valid = False,
  errors = {
    email = [],
    password = [],
    passwordConfirmation = []
  }
 }

type Msg = Email String | Password String | PasswordConfirmation String | Submit

update : Msg -> Model -> Model
update msg model =
  case msg of
    Email email ->
      let
        existingErrors = model.errors
        errors =
          if validEmail email then
            { existingErrors | email = [] }
          else if String.length email < 1 then
            { existingErrors | email = ["Email can't be blank."] }
          else
            { existingErrors | email = ["Please enter a valid email."] }
      in
        { model | email = email, errors = errors }
    Password password ->
      let
        existingErrors = model.errors
        errors =
          if validPassword password then
            { existingErrors | password = [] }
          else if String.length password < 1 then
            { existingErrors | password = ["Email can't be blank."] }
          else
            { existingErrors | password = ["Please enter a valid password."] }
      in
        { model | password = password, errors = errors }
    PasswordConfirmation passwordConfirmation ->
      let
        existingErrors = model.errors
        errors =
          if model.password == passwordConfirmation then
            { existingErrors | passwordConfirmation = [] }
          else
            { existingErrors | passwordConfirmation = ["Passwords don't match."] }
      in
        { model | passwordConfirmation = passwordConfirmation, errors = errors }
    Submit ->
      let
        valid =
          isValid model

        updatedModel =
          { model | valid = valid }
      in
        attemptSubmit updatedModel

view : Model -> Html Msg
view model =
  div [class "form", id "registration-form"] [
    div [class "field", id "email"] [
      input [type' "email", placeholder "Email", onInput Email] [],
      div [class "errors", style [("color", "red")]] [text (String.join " " model.errors.email)]
    ],

    div [class "field", id "password"] [
      input [type' "password", placeholder "Password", onInput Password] [],
      div [class "errors", style [("color", "red")]] [text (String.join " " model.errors.password)]
    ],

    div [class "field", id "passwordConfirmation"] [
      input [type' "password", placeholder "Password Confirmation", onInput PasswordConfirmation] [],
      div [class "errors", style [("color", "red")]] [text (String.join " " model.errors.passwordConfirmation)]
    ],

    div [class "button", id "submit"] [
      button [type' "submit", onClick Submit] [text "Submit"]
    ]
  ]

isValid : Model -> Bool
isValid model =
  let
    emailIsValid : Bool
    emailIsValid = List.isEmpty model.errors.email

    passwordIsValid : Bool
    passwordIsValid = List.isEmpty model.errors.password

    passwordsMatch : Bool
    passwordsMatch = List.isEmpty model.errors.passwordConfirmation

    valid : Bool
    valid = emailIsValid && passwordIsValid && passwordsMatch
  in
    valid

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
