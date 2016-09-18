module Pages.Counter.View exposing (view)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick)
import Pages.Counter.Model exposing (..)
import Pages.Counter.Update exposing (..)


view : Model -> Html Msg
view model =
    div []
        [ div [ class "container" ]
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
        ]
