module App.Update exposing (init, update, Msg(..))

import App.Model exposing (..)
import Exts.RemoteData exposing (RemoteData(..), WebData)
import User.Model exposing (..)
import Pages.Counter.Update exposing (Msg)


type Msg
    = PageCounter Pages.Counter.Update.Msg
    | SetActivePage Page


init : ( Model, Cmd Msg )
init =
    emptyModel ! []


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        PageCounter msg ->
            let
                ( val, cmds, user ) =
                    Pages.Counter.Update.update msg model.pageCounter

                model' =
                    { model | pageCounter = val }

                model'' =
                    case user of
                        -- If user was successfuly fetched, reditect to my
                        -- account page.
                        Success _ ->
                            update (SetActivePage MyAccount) model'
                                |> fst

                        _ ->
                            model'
            in
                ( model'', Cmd.map PageLogin cmds )

        SetActivePage page ->
            { model | activePage = setActivePageAccess model.user page } ! []
