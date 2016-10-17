module Main exposing (Config, TextUpString, toHtml)

import Css
import Html
import Html.Attributes


type alias Config a =
    { a | plain : Css.Mixin }


type alias TextUpString a =
    ( String, Config a -> Css.Mixin )


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



{- *** EXAMPLE STUFF *** -}


defaultConfig : Config { attn1 : Css.Mixin, attn2 : Css.Mixin }
defaultConfig =
    { plain = Css.fontFamily Css.cursive
    , attn1 = Css.mixin [ Css.fontFamily Css.fantasy, Css.textTransform Css.uppercase, Css.color (Css.hex "fff987") ]
    , attn2 = Css.mixin [ Css.fontFamily Css.monospace, Css.textDecoration Css.overline ]
    }


main : Html.Html msg
main =
    [ ( "I'm a string I'd like to present on the page", .plain )
    , ( ".... here are some more thoughts....", .attn1 )
    , ( "Finally, let's end here.", .attn2 )
    , ( "blah blah blah", .attn1 )
    ]
        |> toHtml defaultConfig
