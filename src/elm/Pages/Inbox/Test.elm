module Pages.Inbox.Test exposing (..)

import ElmTest exposing (..)
import Pages.Inbox.Model as Inbox exposing (emptyModel, Model)
import Pages.Inbox.Update as Inbox exposing (..)


decrementActionSuite : Test
decrementActionSuite =
    suite "Decrement action"
        [ test "negative count" (assertEqual -2 (updateInbox Inbox.Decrement -1))
        , test "zero count" (assertEqual -1 (updateInbox Inbox.Decrement 0))
        , test "positive count" (assertEqual 0 (updateInbox Inbox.Decrement 1))
        ]


incrementActionSuite : Test
incrementActionSuite =
    suite "Increment action"
        [ test "negative count" (assertEqual 0 (updateInbox Inbox.Increment -1))
        , test "zero count" (assertEqual 1 (updateInbox Inbox.Increment 0))
        , test "positive count" (assertEqual 2 (updateInbox Inbox.Increment 1))
        ]


updateInbox : Inbox.Msg -> Int -> Inbox.Model
updateInbox action initialModel =
    fst <| Inbox.update action initialModel


all : Test
all =
    suite "Inbox tests"
        [ decrementActionSuite
        , incrementActionSuite
        ]
