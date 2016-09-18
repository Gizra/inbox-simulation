module Pages.Inbox.Update exposing (update, Msg(..))

import Email.Model exposing (..)
import Pages.Inbox.Model as Inbox exposing (..)


init : ( Model, Cmd Msg )
init =
    emptyModel ! []


type Msg
    = SetSelectedEmail (Maybe EmailType)


update : Msg -> Model -> ( Model, Cmd Msg )
update action model =
    case action of
        SetSelectedEmail name ->
            -- If same email is selected, we un-select the emails.
            let
                selectedEmail =
                    case model.selectedEmail of
                        Nothing ->
                            name

                        Just val ->
                            case name of
                                Nothing ->
                                    name

                                Just val' ->
                                    if val == val' then
                                        Nothing
                                    else
                                        Just val'
            in
                { model | selectedEmail = selectedEmail } ! []
