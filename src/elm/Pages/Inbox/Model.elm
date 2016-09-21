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
    , emailsStatus = Dict.insert "Urgent" 0 Dict.empty
    }



-- Get only the emails that should be delivered "immediately".


getImmediateEmails : List ( EmailType, Email ) -> List EmailType
getImmediateEmails emails =
    List.filter (\( emailType, email ) -> email.emailDelivery == Immediate) emails
        |> List.map fst



-- @todo: Get mail from JSON file


emails : List ( EmailType, Email )
emails =
    [ ( "Urgent"
      , { from = "Josie Packard"
        , email = "<josie@greatnortherco.com>"
        , subject = "Urgent - need draft of the report"
        , teaser = "Can I get an update on the latest version of the"
        , body =
            """
<p>
    John,
</p>

<p>
    Can I get an update on the latest version of the proposal to working group. The meeting is on Thursday and I think it's important that we all be on the same page coming into the meeting. If everyone has had a chance to vet the document in advance, I think that we have a better chance of moving the proposal to the next stage.
</p>

    <img src="http://placehold.it/350x150">

<p>
I think the proposal has wide implications for the way we do business and it would be a shame for it to get held up at this stage because nobody had eyes on it before the meeting.
</p>

<p>
I appreciate your attention to this!
</p>

Thanks, <br/>
Josie

Josie Packard
SVP for Financial Products
Great Northern Company
            """
        , emailDelivery = Immediate
        , options =
            Dict.fromList
                [ ( 1, EmailOption "Respond to Josie explaining that the proposal is on track to be delivered tomorrow, at least 24 hours in advance of the meeting" 10 Nothing )
                , ( 2, EmailOption "Respond to Josie explaining that there is not enough time to complete the draft before the meeting and that she should dedicate the first 10 minutes of the meeting to reviewing the document." 50 Nothing )
                , ( 3, EmailOption "Respond to Josie's email after you have completed the draft." 100 Nothing )
                ]
        }
      )
    , ( "Vacation"
      , { from = "Dale Cooper"
        , email = "<dale@greatnortherco.com>"
        , subject = "Corporate Vacation Policy"
        , teaser = " Hi Everyone, It's come to our attention that"
        , body =
            """
              Hi Everyone,

It has come to our attention that the updated guidance on the corporate vacation policy contained an error. Please note that employees do not have unlimited vacation days as part of the revised policy.

This email notification serves as an effective update of the corporate vacation policy until a new policy statement can be drafted. Please reply immediately to this email to acknowledge receipt of this communication and acceptance of the update.

Sincerely,
Dale Cooper

Dale Cooper
Human Resources Director
Great Northern Company
              """
        , emailDelivery = Immediate
        , options =
            Dict.fromList
                [ ( 1, EmailOption "Respond immediately acknowledging that you have received the correspondence and accept the policy." 15 Nothing )
                , ( 2, EmailOption "Reply to all requesting clarification if vacation days taken since the policy update will count toward allowed vacation time." 75 Nothing )
                , ( 3, EmailOption "Move on to another email, respond later." 55 <| Just "VacationIgnoreResponse" )
                ]
        }
      )
    , ( "London"
      , { from = "Leo Johnson"
        , email = "<leo@greatnortherco.com>"
        , subject = "Instructions to our office in London"
        , teaser = " Dear Mr. Smith, I just wanted to point out that in the instructions"
        , body =
            """
              Dear Mr. Smith,

I just wanted to point out that in the instructions you sent to out global network, you failed to mention that for our London office, disclosure documentation needs to be delivered in hard and electronic format as is the custom here. This is a part of our workflow that is crucial to maintaining client confidence.

As I'm sure you understand, it is important to take into account local customs and business practice when circulating procedural documentation to our  network of 53 offices worldwide. It's a daunting task, but one that is of the utmost importance.

Thanks you for your attention to this matter. I kindly request that you reissue the instructions with correction to this matter.

Kindly Yours,
Leo Johnson

Leo Johnson
General Director, London Office
Great Northern Company
              """
        , emailDelivery = Immediate
        , options =
            Dict.fromList
                [ ( 1, EmailOption "Respond immediately indicating that you will review and revise the instructions." 15 Nothing )
                , ( 2, EmailOption "Respond immediately indicating that you understand the concern, but accommodations like this cannot be made for each of the global offices." 75 Nothing )
                , ( 3, EmailOption "Move on to another email, respond later." 55 <| Just "LondonIgnoreResponse" )
                ]
        }
      )
    , ( "VacationIgnoreResponse"
      , { from = "Dale Cooper"
        , email = "<dale@greatnortherco.com>"
        , subject = "Important: Response Required"
        , teaser = "It is important that you respond immediately to the previous"
        , body =
            """
It is important that you respond immediately to the previous correspondence regarding the corporate vacation policy. Failure to do so may result in immediate suspension of employee benefits.

Thank you for your attention.

Sincerely,
Dale Cooper

Dale Cooper
Human Resources Director
Great Northern Company
          """
        , emailDelivery = Delayed
        , options =
            Dict.fromList
                [ ( 1, EmailOption "Respond immediately to this email acknowledging that you have received the correspondence and accept the policy." 15 Nothing )
                , ( 2, EmailOption "Respond immediately to the prior email acknowledging that you have received the correspondence and accept the policy." 25 Nothing )
                , ( 3, EmailOption "Move on to another email, respond later." 25 Nothing )
                ]
        }
      )
    , ( "LondonIgnoreResponse"
      , { from = "Leo Johnson"
        , email = "<leo@greatnortherco.com>"
        , subject = "Re: Instructions to our office in London"
        , teaser = " Dear Mr. Smith, I just wanted to point out that in the instructions"
        , body =
            """
              Dear Mr. Smith,

Just following up on the previous issue. Please acknowledge.

Yours,
Leo Johnson

Leo Johnson
General Director, London Office
Great Northern Company
              """
        , emailDelivery = Delayed
        , options =
            Dict.fromList
                [ ( 1, EmailOption "Respond immediately indicating that you will review and revise the instructions." 15 Nothing )
                , ( 2, EmailOption "Respond immediately indicating that you understand the concern, but accommodations like this cannot be made for each of the global offices." 75 Nothing )
                , ( 3, EmailOption "Move on to another email, respond later." 25 Nothing )
                ]
        }
      )
    ]
