module Main exposing (..)

import ElmTest exposing (..)
import Pages.Inbox.Test as Inbox exposing (all)


allTests : Test
allTests =
    suite "All tests"
        [ Inbox.all
        ]


main : Program Never
main =
    runSuiteHtml allTests
