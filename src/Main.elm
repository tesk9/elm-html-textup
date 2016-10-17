module Main exposing (Config, TextUpString, toHtml)

{-| A library for going from strings to fancily-formatted Html.

@docs Config, TextUpString, toHtml

-}

import Css
import Html
import Html.Attributes


{-| `Config` is for defining whatever style rules you want. The only
    requirement is that there must be a default `plain` style.

```
config : Config { attn1 : Css.Mixin, attn2 : Css.Mixin }
config =
    { plain = Css.fontFamily Css.cursive
    , attn1 = Css.mixin [ Css.fontFamily Css.fantasy, Css.textTransform Css.uppercase, Css.color (Css.hex "fff987") ]
    , attn2 = Css.mixin [ Css.fontFamily Css.monospace, Css.textDecoration Css.overline ]
    }
```
-}
type alias Config a =
    { a | plain : Css.Mixin }


{-| `TextUpString` specifies how a specific string should be formatted.

```
config : Config {}
config =
    { plain = Css.fontFamily Css.cursive }


textUpString : TextUpString {}
textUpString =
    ( "I'm a plain string.", .plain )
```
-}
type alias TextUpString a =
    ( String, Config a -> Css.Mixin )


{-| `toHtml` produces a span whose inner spans are formatted with inline styles.

```
config : Config { attn1 : Css.Mixin, attn2 : Css.Mixin }
config =
    { plain = Css.fontFamily Css.cursive
    , attn1 = Css.mixin [ Css.fontFamily Css.fantasy, Css.textTransform Css.uppercase, Css.color (Css.hex "fff987") ]
    , attn2 = Css.mixin [ Css.fontFamily Css.monospace, Css.textDecoration Css.overline ]
    }


viewHtml : Html.Html msg
viewHtml =
   [ ( "I'm a plain string.", .plain )
   , ( "....here are some more thoughts....", .attn1 )
   , ( "Attention 2!!!", .attn2 )
   , ( "blah blah blah", .attn1 )
   ]
       |> toHtml config
```
-}
toHtml : Config a -> List (TextUpString a) -> Html.Html msg
toHtml config textUpStrings =
    List.map (view config) textUpStrings
        |> Html.span []


view : Config a -> TextUpString a -> Html.Html msg
view config ( value, styleAccessor ) =
    Html.span
        [ toStyle (styleAccessor config) ]
        [ Html.text value ]


toStyle : Css.Mixin -> Html.Attribute msg
toStyle mixin =
    (Html.Attributes.style << Css.asPairs) [ mixin ]
