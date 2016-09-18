module Pages.Inbox.Test exposing (..)

import ElmTest exposing (..)
import Pages.Inbox.Model as Inbox exposing (emptyModel, Model)
import Pages.Inbox.Update as Inbox exposing (..)


setActiveEmail : Test
setActiveEmail =
    suite "setActiveEmail action"
        [ test "no active email" (assertEqual Nothing (.selectedEmail <| updateInbox <| Inbox.SetSelectedEmail Nothing))
        , test "active email" (assertEqual (Just "Vacation") (.selectedEmail <| updateInbox <| Inbox.SetSelectedEmail <| Just "Vacation"))
        ]


updateInbox : Inbox.Msg -> Inbox.Model
updateInbox action =
    fst <| Inbox.update action emptyModel


all : Test
all =
    suite "Inbox tests"
        [ setActiveEmail
        ]
