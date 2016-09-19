module Pages.Inbox.Model exposing (emptyModel, Model)

import Dict exposing (..)
import Email.Model exposing (..)


type alias Model =
    { emails : Dict EmailType Email
    , selectedEmail : Maybe EmailType
    , shownEmails : List EmailType
    , emailsStatus : EmailsStatus
    }


emptyModel : Model
emptyModel =
    { emails = Dict.fromList emails
    , selectedEmail = Just "Urgent"
    , shownEmails = getImmediateEmails emails
    , emailsStatus = Dict.empty
    }


getImmediateEmails : List ( EmailType, Email ) -> List EmailType
getImmediateEmails emails =
    List.filter (\( emailType, email ) -> email.emailDelivery == Immediate) emails
        |> List.map fst



-- @todo: Get mail from JSON file


emails : List ( EmailType, Email )
emails =
    [ ( "Urgent"
      , { from = "Adam Stewart"
        , email = "<adam@gizra.com>"
        , subject = "Urgent needs attention"
        , teaser = "Can we get an update on the latest version of the"
        , body =
            """
            Adam,

Bacon ipsum dolor amet ham hock short loin shoulder capicola landjaeger sirloin beef ribs. Shank rump leberkas picanha kevin jerky. Ground round short loin shank, tail beef ribs doner pig flank cupim. Pig ham venison tongue alcatra andouille sirloin pancetta bresaola leberkas. Kielbasa meatball alcatra pork shoulder prosciutto pancetta landjaeger short loin shankle andouille. Ham hock short ribs pork belly venison drumstick landjaeger chicken rump fatback doner kevin. Boudin tongue andouille turducken.

Shankle doner filet mignon rump picanha. Pastrami t-bone pork loin sausage. Turducken spare ribs alcatra, sausage sirloin short loin kielbasa ribeye. Tongue tri-tip jerky chicken filet mignon, tail hamburger turkey venison shankle pig ham capicola kevin.

Fatback pig ribeye hamburger biltong landjaeger beef ribs pork belly porchetta tri-tip. Corned beef leberkas cupim rump strip steak ground round ball tip tongue, shankle venison flank sirloin kielbasa bresaola. Hamburger picanha pork loin capicola salami pancetta. Boudin kielbasa shankle pig, beef ribs pancetta capicola porchetta spare ribs corned beef pork belly biltong sirloin short loin. Pig hamburger landjaeger meatball boudin, tail flank kevin filet mignon ribeye fatback.

Adam
            """
        , emailDelivery = Immediate
        , options =
            Dict.fromList
                [ ( 1, EmailOption "Run screaming" 10 Nothing )
                , ( 2, EmailOption "Forward to manager" 50 Nothing )
                , ( 3, EmailOption "BCC all" 100 Nothing )
                ]
        }
      )
    , ( "Vacation"
      , { from = "Adar Earon"
        , email = "<adar@gizra.com>"
        , subject = "Company holiday"
        , teaser = "Hi folks, It's the holidays season"
        , body =
            """
              Hi folks,

It's the holidays season, and we want some holidays
              """
        , emailDelivery = Immediate
        , options =
            Dict.fromList
                [ ( 1, EmailOption "Subscribe" 15 Nothing )
                , ( 2, EmailOption "Ignore" 55 Nothing )
                , ( 3, EmailOption "Forward to everybody" 75 Nothing )
                ]
        }
      )
    , ( "VacationIgnoreResponse"
      , { from = "Adar Earon"
        , email = "<adar@gizra.com>"
        , subject = "Are you not coming?"
        , teaser = "You are the only one..."
        , body =
            """
You are the only one... Please reconsider
          """
        , emailDelivery = Delayed
        , options =
            Dict.fromList
                [ ( 1, EmailOption "Approve" 15 Nothing )
                , ( 2, EmailOption "Deny" 25 Nothing )
                ]
        }
      )
    ]
