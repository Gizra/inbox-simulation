module Pages.Counter.View exposing (view)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick)
import Pages.Counter.Model exposing (..)
import Pages.Counter.Update exposing (..)


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
                                [ text "New"
                                ]
                            ]
                        , a [ class "ui item" ]
                            [ i [ class "trash outline icon" ]
                                [ text "Delete"
                                ]
                            ]
                        , a [ class "ui item" ]
                            [ i [ class "archive icon" ]
                                [ text "Archive"
                                ]
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
                                    [ text "Undo"
                                    ]
                                ]
                            ]
                        ]
                    ]
                , div [ class "content__messages" ]
                    [ div [ class "content__messages__list" ]
                        [ div [ class "ui relaxed divided list" ]
                            [ viewMailItem
                            , viewMailItem
                            , viewMailItem
                            , viewMailItem
                            ]
                        ]
                    , div [ class "content__messages__selected" ]
                        [ div [ class "content__messages__selected__header" ]
                            [ div [ class "content__messages__selected__header_title" ]
                                [ text "Urgent needs attention" ]
                            , div [ class "content__messages__selected__header_sender" ]
                                [ text "Adam Stewart", text "<", text "adam@gizra.com", text ">" ]
                            , div [ class "content__messages__selected__header__reply" ]
                                [ div [ class "content__messages__selected__header__reply_all" ]
                                    [ i [ class "reply all icon" ]
                                        [ text "Reply All"
                                        ]
                                    , i [ class "angle down icon" ]
                                        []
                                    ]
                                ]
                            , div [ class "content__messages__selected__header_date" ]
                                [ text "Tue 9/13/2016 10:26 AM" ]
                            ]
                        , div [ class "content__messages__selected__content" ]
                            [ p []
                                [ text "Adam," ]
                            , p []
                                [ text "Bacon ipsum dolor amet ham hock short loin shoulder capicola landjaeger sirloin beef ribs. Shank rump leberkas picanha kevin jerky. Ground round short loin shank, tail beef ribs doner pig flank cupim. Pig ham venison tongue alcatra\n                                andouille sirloin pancetta bresaola leberkas. Kielbasa meatball alcatra pork shoulder prosciutto pancetta landjaeger short loin shankle andouille. Ham hock short ribs pork belly venison drumstick landjaeger chicken rump fatback\n                                doner kevin. Boudin tongue andouille turducken." ]
                            , p []
                                [ text "Shankle doner filet mignon rump picanha. Pastrami t-bone pork loin sausage. Turducken spare ribs alcatra, sausage sirloin short loin kielbasa ribeye. Tongue tri-tip jerky chicken filet mignon, tail hamburger turkey venison shankle\n                                pig ham capicola kevin." ]
                            , p []
                                [ text "Fatback pig ribeye hamburger biltong landjaeger beef ribs pork belly porchetta tri-tip. Corned beef leberkas cupim rump strip steak ground round ball tip tongue, shankle venison flank sirloin kielbasa bresaola. Hamburger picanha\n                                pork loin capicola salami pancetta. Boudin kielbasa shankle pig, beef ribs pancetta capicola porchetta spare ribs corned beef pork belly biltong sirloin short loin. Pig hamburger landjaeger meatball boudin, tail flank kevin\n                                filet mignon ribeye fatback." ]
                            , p []
                                [ text "Adam" ]
                            ]
                        ]
                    ]
                ]
            ]
        ]


viewMailItem : Html Msg
viewMailItem =
    div [ class "item" ]
        [ div [ class "content__messages__list__checkbox" ]
            [ input [ type' "checkbox" ]
                []
            ]
        , div [ class "content__messages__list__item" ]
            [ div [ class "content__messages__list__item__from" ]
                [ text "Adam Stewart" ]
            , div [ class "content__messages__list__item__subject" ]
                [ text "Urgent needs attention" ]
            , div [ class "content__messages__list__item__content" ]
                [ text "Can we get an update on the latest version of the document." ]
            ]
        ]
