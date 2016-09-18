module Pages.Inbox.Update exposing (update, Msg(..))

import Email.Model exposing (..)
import Pages.Inbox.Model as Inbox exposing (..)


init : ( Model, Cmd Msg )
init =
    emptyModel ! []


type Msg
    = SetActiveEmail (Maybe EmailType)


update : Msg -> Model -> ( Model, Cmd Msg )
update action model =
    case action of
        SetActiveEmail name ->
            { model | selectedEmail = name } ! []
