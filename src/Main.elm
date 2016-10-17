module Main exposing (..)

import Css
import Html
import Html.Attributes


type alias Config =
    { plain : Css.Mixin
    , attn1 : Css.Mixin
    , attn2 : Css.Mixin
    }


defaultConfig : Config
defaultConfig =
    { plain = Css.fontFamily Css.cursive
    , attn1 = Css.mixin [ Css.fontFamily Css.fantasy, Css.textTransform Css.uppercase ]
    , attn2 = Css.mixin [ Css.fontFamily Css.monospace, Css.textDecoration Css.overline ]
    }


type alias TextUpString =
    ( String, Config -> Css.Mixin )


toHtml : Config -> List TextUpString -> Html.Html msg
toHtml config textUpStrings =
    List.map (view config) textUpStrings
        |> Html.span []


view : Config -> TextUpString -> Html.Html msg
view config ( value, styleAccessor ) =
    Html.span
        [ toStyle (styleAccessor config) ]
        [ Html.text value ]


toStyle : Css.Mixin -> Html.Attribute msg
toStyle mixin =
    (Html.Attributes.style << Css.asPairs) [ mixin ]


main : Html.Html msg
main =
    [ ( "I'm a string I'd like to present on the page", .plain )
    , ( ".... here are some more thoughts....", .attn1 )
    , ( "Finally, let's end here.", .attn2 )
    , ( "blah blah blah", .attn1 )
    ]
        |> toHtml defaultConfig
