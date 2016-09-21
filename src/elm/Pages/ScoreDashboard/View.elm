module Pages.ScoreDashboard.View exposing (view)

import Json.Encode as Json
import Html exposing (..)
import Html.Attributes exposing (..)
import Pages.Inbox.Model exposing (..)
import Pages.Inbox.Utils exposing (..)


-- VIEW


view : Model -> Html a
view model =
    div [ class "ui container" ]
        [ div [ class "ui segment stacked" ]
            [ table [ class "ui very basic collapsing celled table" ]
                [ thead []
                    [ tr []
                        [ th [ rowspan 2 ]
                            [ text "Employee" ]
                        , th [ rowspan 2 ]
                            [ text "Overall Progress" ]
                        , th [ colspan 2 ]
                            [ text "Inbox Simulation" ]
                        , th [ colspan 2 ]
                            [ text "Leadership Assessment" ]
                        , th [ rowspan 2 ]
                            [ text "Overall Score" ]
                        ]
                    , tr []
                        [ th []
                            [ text "Time to Complete" ]
                        , th []
                            [ text "Score" ]
                        , th []
                            [ text "Time to Complete" ]
                        , th []
                            [ text "Score" ]
                        ]
                    ]
                , tbody [] (List.map (hardcodedRows model) dummyScores)
                ]
            ]
        ]


type alias ScoreAndTime =
    { score :
        Int
        -- @todo: Change to Time
    , time : String
    }


type alias Score =
    { name : String
    , position : String
    , progress : Int
    , inboxSimulation : ScoreAndTime
    , leadershipAssessment : ScoreAndTime
    , overallScore : Int
    }


dummyScores : List Score
dummyScores =
    [ { name = "John Q. Smith"
      , position = "Human Resources"
      , progress = 96
      , inboxSimulation = ScoreAndTime 22 "10:22"
      , leadershipAssessment = ScoreAndTime 45 "12:10"
      , overallScore = 0
      }
    , { name = "Laura Palmer"
      , position = "Financial Services"
      , progress = 50
      , inboxSimulation = ScoreAndTime 66 "15:22"
      , leadershipAssessment = ScoreAndTime 25 "20:09"
      , overallScore = 91
      }
    , { name = "Josie Packard"
      , position = "Financial Services"
      , progress = 22
      , inboxSimulation = ScoreAndTime 38 "14:22"
      , leadershipAssessment = ScoreAndTime 22 "24:10"
      , overallScore = 60
      }
    , { name = "Dale Cooper"
      , position = "Human Resources"
      , progress = 78
      , inboxSimulation = ScoreAndTime 25 "15:18"
      , leadershipAssessment = ScoreAndTime 36 "20:10"
      , overallScore = 61
      }
    , { name = "Leo Johnson"
      , position = "Human Resources"
      , progress = 34
      , inboxSimulation = ScoreAndTime 62 "14:21"
      , leadershipAssessment = ScoreAndTime 23 "18:04"
      , overallScore = 85
      }
    , { name = "Audrey Horne"
      , position = "Financial Services"
      , progress = 58
      , inboxSimulation = ScoreAndTime 62 "13:28"
      , leadershipAssessment = ScoreAndTime 25 "19:18"
      , overallScore = 87
      }
    ]


hardcodedRows : Model -> Score -> Html msg
hardcodedRows model scoreData =
    let
        -- For the first user in the row, we use the calculated overall score.
        overallScore =
            if scoreData.name == "John Q. Smith" then
                getScore model
            else
                scoreData.overallScore
    in
        tr []
            [ td []
                [ h4 [ class "ui image header" ]
                    [ i [ class "user icon" ]
                        []
                    , div [ class "content" ]
                        [ text scoreData.name
                        , div [ class "sub header" ]
                            [ text scoreData.position ]
                        ]
                    ]
                ]
            , td []
                -- Progress bar
                [ (node "progress")
                    [ value <| toString scoreData.progress
                    , Html.Attributes.max "100"
                    ]
                    []
                ]
            , td []
                [ text scoreData.inboxSimulation.time ]
            , td []
                [ text <| toString scoreData.inboxSimulation.score ]
            , td []
                [ text scoreData.leadershipAssessment.time ]
            , td []
                [ text <| toString scoreData.leadershipAssessment.score ]
            , td []
                [ text <| toString overallScore ]
            ]
