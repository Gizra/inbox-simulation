module Pages.Inbox.Update exposing (update, Msg(..))

import Dict exposing (..)
import Dom.Scroll as Dom exposing (..)
import Email.Model exposing (..)
import Pages.Inbox.Model as Inbox exposing (..)
import Process exposing (sleep)
import Task


init : ( Model, Cmd Msg )
init =
    emptyModel ! []


type Msg
    = DeliverEmail EmailType
    | NoOp
    | SetEmailStatus EmailType Int
    | SetSelectedEmail (Maybe EmailType)


update : Msg -> Model -> ( Model, Cmd Msg )
update action model =
    case action of
        DeliverEmail emailType ->
            -- Rebuild the dict, by appending the new email to the list.
            let
                shownEmails =
                    if (List.any (\type' -> emailType == type') model.shownEmails) then
                        -- Email type is already in the shown emails list.
                        model.shownEmails
                    else
                        -- Append the new email type to the shown list.
                        emailType :: model.shownEmails
            in
                { model | shownEmails = shownEmails } ! []

        NoOp ->
            model ! []

        SetEmailStatus emailType keyOption ->
            let
                emailsStatus =
                    Dict.insert emailType keyOption model.emailsStatus

                cmd =
                    case Dict.get emailType model.emails of
                        Nothing ->
                            []

                        Just email ->
                            case Dict.get keyOption email.options of
                                Nothing ->
                                    []

                                Just option ->
                                    case option.triggerEmail of
                                        Nothing ->
                                            []

                                        Just emailType' ->
                                            -- Sleep for 2 seconds, and send the triggered email.
                                            [ Process.sleep (2 * 1000) |> Task.perform (always <| DeliverEmail emailType') (always <| DeliverEmail emailType') ]
            in
                { model | emailsStatus = emailsStatus } ! cmd

        SetSelectedEmail emailType ->
            let
                -- Set email status
                emailsStatus =
                    case emailType of
                        Nothing ->
                            model.emailsStatus

                        Just val ->
                            case (Dict.get val model.emailsStatus) of
                                Nothing ->
                                    let
                                        model' =
                                            fst <| update (SetEmailStatus val 0) model
                                    in
                                        model'.emailsStatus

                                Just _ ->
                                    model.emailsStatus

                focus =
                    Dom.toTop "selected-email"
            in
                { model
                    | selectedEmail = emailType
                    , emailsStatus = emailsStatus
                }
                    ! [ Task.perform (\_ -> NoOp) (\_ -> NoOp) focus ]
