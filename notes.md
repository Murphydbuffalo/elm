# Notes from the Elm FAQ

## Updating nested fields in records
A less-than-bodacious syntax unfortunately. For `foo = { foo = { bar = "some value" } }`
you could do the following:
```
foo = record.foo
updatedRecord = { record | foo = { bar = "new value" } }
```

## `Html Msg` vs `Html msg` (type variables)
Using a capitalized argument name points to a specific type, `Msg` in this case.
Lowercase arguments have arbitrary names (for example you'll see `a`, `b`, `c`, etc)
and are *type variables*, meaning that any type can be used. Whereas, when specifying
a specific type, only that type is valid. Eg `List String` requires the elements of
the list to be strings. `List foo` means that you can have elements of any type
in the list.

## Compiling Multiple `.elm` files into a single output file
You can run `elm-make Foo.elm Bar.elm --output app.js` and both of your Elm files
will be compiled into a single JS file.

## The `=>` operator
It is relatively common to define `=>` as a function to serve as a shorthand
tuple definition syntax, so that instead of `[("color", "#FFFFFF"), ("width", "300px")]`
you could write `["color" => "#FFFFFF", "width" => "300px"]`

## Conditionally rendering Html
You can use a conditional as you normally would, and then use `Html.text ""` to
render nothing. Eg:
```
if foo then
  div [] [text "Hi"]
else
  text ""
```

## Typeclasses
Elm has 3 "typeclasses" or types encompass multiple types conforming to some shared API.
This is similar to `Enumerable` in Ruby. In Elm we have:

+ `number`, which `Int` and `Float` satisfy the API for.
+ `comparable`, which `Int`, `Float`, `Char`, `String`, `List` and `Tuple` satisfy the API for.
+ And `appendable`, which `String`, `List`, and `text` satisfy the API for.

These typeclasses can be used in type annotations. Eg, `myFunction : number -> number -> Float`
This definition can accept either `Int` or `Float` arguments, although not a mixture
of the two.

## Types vs Type aliases
Just like it sounds: defining a brand new type, vs giving an additional name to
and existing type. Eg `type alias Model = Int`.

## Don't forget to install common packages!
Such as `elm-lang/html`, `elm-lang/svg`, etc.
