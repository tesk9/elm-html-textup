module Main exposing (..)

import Html


type alias Config =
    {}


type Theme
    = StrikeThrough


type alias TextUpString =
    ( String, List Theme )


toHtml : Config -> List TextUpString -> Html.Html msg
toHtml config textUpStrings =
    Html.text "Hello, world"
