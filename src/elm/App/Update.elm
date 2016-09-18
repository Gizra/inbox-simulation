module App.Update exposing (init, update, Msg(..))

import App.Model exposing (..)
import Pages.Inbox.Update exposing (Msg)


type Msg
    = PageInbox Pages.Inbox.Update.Msg
    | SetActivePage Page


init : ( Model, Cmd Msg )
init =
    emptyModel ! []


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        PageInbox msg ->
            let
                ( val, cmds ) =
                    Pages.Inbox.Update.update msg model.pageInbox

                model' =
                    { model | pageInbox = val }
            in
                ( model', Cmd.map PageInbox cmds )

        SetActivePage page ->
            { model | activePage = page } ! []
