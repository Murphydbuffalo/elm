import Html exposing (Html, div, button, input, text, br)
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
          { existingErrors | email = (validateEmail email) }
      in
        { model | email = email, errors = errors }
    Password password ->
      let
        existingErrors = model.errors
        errors =
          {
            existingErrors |
            password = (validatePassword password),
            passwordConfirmation = (validatePasswordsMatch password model.passwordConfirmation)
          }
      in
        { model | password = password, errors = errors }
    PasswordConfirmation passwordConfirmation ->
      let
        existingErrors = model.errors
        errors =
          { existingErrors | passwordConfirmation = validatePasswordsMatch model.password passwordConfirmation }
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
      div [class "errors", style [("color", "red")]] [text (String.join " " model.errors.email)],
      br [] []
    ],

    div [class "field", id "password"] [
      input [type' "password", placeholder "Password", onInput Password] [],
      div [class "errors", style [("color", "red")]] [text (String.join " " model.errors.password)],
      br [] []
    ],

    div [class "field", id "passwordConfirmation"] [
      input [type' "password", placeholder "Confirm Password", onInput PasswordConfirmation] [],
      div [class "errors", style [("color", "red")]] [text (String.join " " model.errors.passwordConfirmation)],
      br [] []
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

validateEmail : String -> List String
validateEmail email =
  let
    regex =
      Regex.regex ".+@.+\\..+"

    errors =
      if Regex.contains regex email then
        []
      else if String.length email < 1 then
        ["Email can't be blank."]
      else
        ["Please enter a valid email."]

  in
    errors

validatePassword : String -> List String
validatePassword password =
  let
    errors =
      if String.length password < 8 then
        ["Please enter a password with at least 8 characters."]
      else if not (passwordHasRequiredChars password) then
        ["Please enter a password with at least one upper case letter, one lower case letter, and one number."]
      else
        []

  in
    errors

validatePasswordsMatch : String -> String -> List String
validatePasswordsMatch password passwordConfirmation =
  if password == passwordConfirmation then
    []
  else
    ["Passwords don't match."]

passwordHasRequiredChars : String -> Bool
passwordHasRequiredChars string =
  String.any Char.isDigit string &&
  String.any Char.isUpper string &&
  String.any Char.isLower string

attemptSubmit : Model -> Model
attemptSubmit model =
  -- if model.valid then
    -- Make HTTP call
    -- Clear form

  model
