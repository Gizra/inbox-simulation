module Pages.Inbox.Update exposing (update, Msg(..))

import Pages.Inbox.Model as Inbox exposing (..)


init : ( Model, Cmd Msg )
init =
    emptyModel ! []


type Msg
    = NoOp


update : Msg -> Model -> ( Model, Cmd Msg )
update action model =
    case action of
        NoOp ->
            model ! []
