module Email.Model exposing (..)


type alias EmailType =
    String


type alias Email =
    { from : String
    , email : String
    , subject : String
    , teaser : String
    , body : String
    , options : List EmailOption
    }


type alias EmailOption =
    { label : String
    , score : Int
    }
