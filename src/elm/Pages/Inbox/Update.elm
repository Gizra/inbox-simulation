module Pages.Inbox.Update exposing (update, Msg(..))

import Dict exposing (..)
import Email.Model exposing (..)
import Pages.Inbox.Model as Inbox exposing (..)


init : ( Model, Cmd Msg )
init =
    emptyModel ! []


type Msg
    = DeliverEmail EmailType
    | SetEmailStatus EmailType Int
    | SetSelectedEmail (Maybe EmailType)


update : Msg -> Model -> ( Model, Cmd Msg )
update action model =
    case action of
        DeliverEmail emailType ->
            -- Rebuild the dict, by appending the new email to the list.
            let
                shownEmails =
                    emailType :: model.shownEmails
            in
                { model | shownEmails = shownEmails } ! []

        SetEmailStatus emailType keyOption ->
            let
                model' =
                    update (DeliverEmail emailType) model
                        |> fst

                emailsStatus =
                    Dict.insert emailType keyOption model'.emailsStatus
            in
                { model' | emailsStatus = emailsStatus } ! []

        SetSelectedEmail emailType ->
            -- If same email is selected, we un-select the emails.
            let
                selectedEmail =
                    case model.selectedEmail of
                        Nothing ->
                            emailType

                        Just val ->
                            case emailType of
                                Nothing ->
                                    emailType

                                Just val' ->
                                    if val == val' then
                                        Nothing
                                    else
                                        Just val'

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
            in
                { model
                    | selectedEmail = selectedEmail
                    , emailsStatus = emailsStatus
                }
                    ! []
