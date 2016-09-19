module Email.Model exposing (..)

import Dict exposing (..)


type alias EmailType =
    String


type alias EmailsStatus =
    Dict EmailType Int


type EmailDelivery
    = Delayed
    | Immediate


type alias Email =
    { from : String
    , email : String
    , subject : String
    , teaser : String
    , body : String
    , emailDelivery : EmailDelivery
    , options : Dict Int EmailOption
    }


type alias EmailOption =
    { label : String
    , score : Int
    , triggerEmail : Maybe EmailType
    }
