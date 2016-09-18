module Email.Model exposing (..)

import Dict exposing (..)


type alias EmailType =
    String

type alias EmailsStatus = Dict EmailType Int


type alias Email =
    { from : String
    , email : String
    , subject : String
    , teaser : String
    , body : String
    , options : Dict Int EmailOption
    }


type alias EmailOption =
    { label : String
    , score : Int
    }
