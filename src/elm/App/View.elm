module App.View exposing (..)

import Html exposing (..)
import Html.Attributes exposing (class, classList, href, src, style, target)
import Html.App as Html
import Html.Events exposing (onClick)
import App.Model exposing (..)
import App.Update exposing (..)
import Pages.Inbox.View exposing (..)
import Pages.PageNotFound.View exposing (..)
import Pages.ScoreDashboard.View exposing (..)


view : Model -> Html Msg
view model =
    div []
        [ viewHeader model
        , viewMainContent model
        , viewFooter
        ]


viewHeader : Model -> Html Msg
viewHeader model =
    div [ class "ui container header-menu" ]
        [ div [ class "ui secondary pointing menu" ] (navbarAnonymous model)
        ]


navbarAnonymous : Model -> List (Html Msg)
navbarAnonymous model =
    [ a
        [ classByPage Inbox model.activePage
        , onClick <| SetActivePage Inbox
        ]
        [ text "Inbox" ]
    , a
        [ classByPage ScoreDashboard model.activePage
        , onClick <| SetActivePage ScoreDashboard
        ]
        [ text "Score Dashboard" ]
    ]


viewPageNotFoundItem : Page -> Html Msg
viewPageNotFoundItem activePage =
    a
        [ classByPage PageNotFound activePage
        , onClick <| SetActivePage PageNotFound
        ]
        [ text "404 page" ]


viewMainContent : Model -> Html Msg
viewMainContent model =
    case model.activePage of
        Inbox ->
            Html.map PageInbox (Pages.Inbox.View.view model.pageInbox)

        PageNotFound ->
            -- We don't need to pass any cmds, so we can call the view directly
            Pages.PageNotFound.View.view

        ScoreDashboard ->
            Pages.ScoreDashboard.View.view model.pageInbox


viewFooter : Html Msg
viewFooter =
    div
        [ class "ui inverted vertical footer segment form-page"
        ]
        [ div [ class "ui container" ]
            [ a
                [ href "http://gizra.com"
                , target "_blank"
                ]
                [ text "Gizra" ]
            , span [] [ text " // " ]
            , a
                [ href "https://github.com/Gizra/inbox-training"
                , target "_blank"
                ]
                [ text "Github" ]
            ]
        ]


{-| Get menu items classes. This function gets the active page and checks if
it is indeed the page used.
-}
classByPage : Page -> Page -> Attribute a
classByPage page activePage =
    classList
        [ ( "item", True )
        , ( "active", page == activePage )
        ]
