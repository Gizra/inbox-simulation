module Pages.Inbox.View exposing (view)

import Dict exposing (..)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick)
import Pages.Inbox.Model exposing (..)
import Pages.Inbox.Update exposing (..)
import Email.Model exposing (..)


view : Model -> Html Msg
view model =
    div [ class "ui container" ]
        [ viewNavbar model
        , viewMain model
        ]


viewNavbar : Model -> Html Msg
viewNavbar model =
    div [ class "container" ]
        [ div [ class "ui inverted menu top__menu" ]
            [ a [ class "ui item microsoft_logo" ]
                [ i [ class "grid layout icon" ]
                    []
                ]
            , div [ class "header item" ]
                [ text "Outlook Mail" ]
            , div [ class "right menu" ]
                [ a [ class "ui item" ]
                    [ i [ class "skype icon" ]
                        []
                    ]
                , a [ class "ui item" ]
                    [ i [ class "alarm icon" ]
                        []
                    ]
                , a [ class "ui item" ]
                    [ i [ class "setting icon" ]
                        []
                    ]
                , a [ class "ui item" ]
                    [ i [ class "help icon" ]
                        []
                    ]
                ]
            ]
        ]


viewMain : Model -> Html Msg
viewMain model =
    div [ class "ui container" ]
        [ div [ class "main" ]
            [ div [ class "sidebar_left" ]
                [ div [ class "sidebar_left__search" ]
                    [ span [ class "sidebar_left__search__text" ]
                        [ text "Search Mail and People" ]
                    , span [ class "sidebar_left__search__icon" ]
                        [ i [ class "search icon" ]
                            []
                        ]
                    ]
                , div [ class "sidebar_left__folders" ]
                    [ div [ class "ui vertical secondary menu" ]
                        [ div [ class "item" ]
                            [ div [ class "header" ]
                                [ text "Folders" ]
                            , div [ class "menu" ]
                                [ a [ class "item" ]
                                    [ text "Inbox" ]
                                , a [ class "item" ]
                                    [ text "Junk Mail" ]
                                , a [ class "item" ]
                                    [ text "Drafts" ]
                                , a [ class "item" ]
                                    [ text "Sent Items" ]
                                , a [ class "item" ]
                                    [ text "Deleted Items" ]
                                ]
                            ]
                        ]
                    ]
                ]
            , div [ class "content" ]
                [ div [ class "content__toolbar" ]
                    [ div [ class "ui secondary menu" ]
                        [ a [ class "ui item" ]
                            [ i [ class "plus square outline icon" ]
                                []
                            , text "New"
                            ]
                        , a [ class "ui item" ]
                            [ i [ class "trash outline icon" ]
                                []
                            , text "Delete"
                            ]
                        , a [ class "ui item" ]
                            [ i [ class "archive icon" ]
                                []
                            , text "Archive"
                            ]
                        , a [ class "ui item" ]
                            [ text "Junk"
                            , i [ class "angle down icon" ]
                                []
                            ]
                        , a [ class "ui item" ]
                            [ text "Sweep" ]
                        , a [ class "ui item" ]
                            [ text "Move to"
                            , i [ class "angle down icon" ]
                                []
                            ]
                        , a [ class "ui item" ]
                            [ text "Categories"
                            , i [ class "angle down icon" ]
                                []
                            ]
                        , div [ class "ui right secondary menu" ]
                            [ a [ class "ui item" ]
                                [ i [ class "undo icon" ]
                                    []
                                , text "Undo"
                                ]
                            ]
                        ]
                    ]
                , div [ class "content__messages" ]
                    [ div [ class "content__messages__list" ]
                        [ div [ class "ui relaxed divided list" ]
                            (List.map (viewMailItem model.emails model.emailsStatus) model.shownEmails)
                        ]
                    , (viewSelectedEmail model)
                    ]
                ]
            ]
        ]


viewMailItem : Dict EmailType Email -> EmailsStatus -> EmailType -> Html Msg
viewMailItem emails emailsStatus emailType =
    case Dict.get emailType emails of
        Nothing ->
            -- This shouldn't ever happen.
            div [] []

        Just email ->
            let
                notOpened =
                    case Dict.get emailType emailsStatus of
                        Nothing ->
                            True

                        Just _ ->
                            False
            in
                div [ class "item" ]
                    [ div [ class "content__messages__list__checkbox" ]
                        [ input [ type' "checkbox" ]
                            []
                        ]
                    , div
                        [ classList
                            [ ( "content__messages__list__item", True )
                            , ( "not-opened", notOpened )
                            ]
                        ]
                        [ a
                            [ class "content__messages__list__item__from"
                            , (onClick <| SetSelectedEmail <| Just emailType)
                            ]
                            [ text email.from ]
                        , div [ class "content__messages__list__item__subject" ]
                            [ text email.subject ]
                        , div [ class "content__messages__list__item__content" ]
                            [ text email.teaser ]
                        ]
                    ]


viewSelectedEmail : Model -> Html Msg
viewSelectedEmail model =
    case model.selectedEmail of
        Nothing ->
            div [] []

        Just name ->
            let
                memail =
                    Dict.get name model.emails
            in
                case memail of
                    Nothing ->
                        div [] []

                    Just email ->
                        div [ class "content__messages__selected" ]
                            [ div [ class "content__messages__selected__header" ]
                                [ div [ class "ui form segment" ]
                                    [ div [ class "grouped fields" ]
                                        [ label [] [ text "What should you do next?" ]
                                        , div [] (List.map (viewShowOption name model.emailsStatus) <| Dict.toList email.options)
                                        ]
                                    ]
                                , div [ class "content__messages__selected__header_title" ]
                                    [ text email.subject ]
                                , div [ class "content__messages__selected__header_sender" ]
                                    [ text email.from ]
                                , div [ class "content__messages__selected__header__reply" ]
                                    [ div [ class "content__messages__selected__header__reply_all" ]
                                        [ i [ class "reply all icon" ]
                                            []
                                        , text "Reply All"
                                        , i [ class "angle down icon" ]
                                            []
                                        ]
                                    ]
                                , div [ class "content__messages__selected__header_date" ]
                                    [ text "Tue 9/13/2016 10:26 AM" ]
                                ]
                            , div [ class "content__messages__selected__content" ]
                                [ text email.body
                                ]
                            ]


viewShowOption : EmailType -> EmailsStatus -> ( Int, EmailOption ) -> Html Msg
viewShowOption emailType emailsStatus ( optionKey, option ) =
    let
        isChecked =
            case (Dict.get emailType emailsStatus) of
                Nothing ->
                    False

                Just index ->
                    optionKey == index
    in
        div [ class "field" ]
            [ div [ class "ui radio checkbox" ]
                [ input
                    [ type' "radio"
                    , name "radio"
                    , checked isChecked
                    , onClick <| SetEmailStatus emailType optionKey
                    ]
                    []
                , label []
                    [ text option.label ]
                ]
            ]
