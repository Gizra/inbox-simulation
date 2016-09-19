module App.Model exposing (emptyModel, Model, Page(..))

import Pages.Inbox.Model exposing (emptyModel, Model)


type Page
    = Inbox
    | PageNotFound
    | ScoreDashboard


type alias Model =
    { activePage : Page
    , pageInbox : Pages.Inbox.Model.Model
    }


emptyModel : Model
emptyModel =
    { activePage = Inbox
    , pageInbox = Pages.Inbox.Model.emptyModel
    }
