module Pages.Inbox.Utils exposing (getScore)

import Pages.Inbox.Model as Inbox exposing (..)
import Dict exposing (..)


getScore : Model -> Int
getScore model =
    let
        calculate emailType optionKey total =
            case (Dict.get emailType model.emails) of
                Nothing ->
                    0

                Just email ->
                    case (Dict.get optionKey email.options) of
                        Nothing ->
                            0

                        Just option ->
                            option.score + total
    in
        Dict.foldl calculate 0 model.emailsStatus
