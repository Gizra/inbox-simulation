module Pages.Inbox.Update exposing (update, Msg(..))

import Pages.Inbox.Model as Inbox exposing (..)


init : ( Model, Cmd Msg )
init =
    emptyModel ! []


type Msg
    = Decrement
    | Increment


update : Msg -> Model -> ( Model, Cmd Msg )
update action model =
    case action of
        Decrement ->
            ( model - 1
            , Cmd.none
            )

        Increment ->
            ( model + 1
            , Cmd.none
            )
