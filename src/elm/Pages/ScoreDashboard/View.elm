module Pages.ScoreDashboard.View exposing (view)

import Html exposing (a, div, h2, text, Html)
import Html.Attributes exposing (class, href)
import Pages.Inbox.Model exposing (..)
import Pages.Inbox.Utils exposing (..)


-- VIEW


view : Model -> Html a
view model =
    div [ class "ui container" ]
        [ text <| toString <| getScore model
        ]
