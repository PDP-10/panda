;;; -*- Mode:LISP; Package:ZBABYL-INTERNALS; -*-

(DEFINE-FILTER Expired
  "expired mail"
  (PRECEDES EXPIRATION-DATE))

(DEFINE-FILTER After-Startup
  "recent mail and reminders"
  (OR (LABEL "recent") (FILTER-CALL "Reminders")))

(DEFINE-FILTER Reminders
  "reminders"
  (AND
   (NOT (LABEL "deleted"))
   (OR
    (LABEL "RemindNow")
    (AND
     (PRECEDES START-DATE)
     (OR (NOT (SEARCH-FIELD STOP-DATE))
	 (FOLLOWS STOP-DATE))
     (NOT (FILTER-CALL "Expired"))))))

(DEFINE-FILTER Before-Expunge
  "messages which have expired but not been deleted"
  (AND (NOT (LABEL "deleted")) (FILTER-CALL "Expired")))

(DEFINE-FILTER All
  "messages"
  T)

(DEFINE-FILTER Containing-String 
  "messages containing the given string"
  (SEARCH (PROMPT STRING "Containing string")))


(DEFINE-FILTER Deleted
  "deleted messages"
  (LABEL "deleted"))

(DEFINE-FILTER UnDeleted	      
  "messages which are not deleted"
  (NOT (FILTER-CALL "Deleted")))

(DEFINE-FILTER Labeled
  "messages with the given label"
  (LABEL (PROMPT LABEL "Labeled")))

(DEFINE-FILTER UnLabeled	      
  "messages without the given label"
  (NOT (LABEL (PROMPT LABEL "Not labeled"))))

(DEFINE-FILTER   Seen	      
  "seen messages"
  (NOT (FILTER-CALL "UnSeen")))

(DEFINE-FILTER UnSeen	      
  "unseen messages"
  (LABEL "unseen"))

(DEFINE-FILTER OR		      
  "messages which match either criteria"
  (OR
   (FILTER-CALL (PROMPT FILTER "Or-1"))
   (FILTER-CALL (PROMPT FILTER "Or-2"))))

(DEFINE-FILTER AND		      
  "messages which match both criteria"
  (AND
   (FILTER-CALL (PROMPT FILTER "And-1"))
   (FILTER-CALL (PROMPT FILTER "And-2"))))

(DEFINE-FILTER NOT		      
  "messages which don't match the given criteria"
  (NOT (FILTER-CALL (PROMPT FILTER "Not"))))

(DEFINE-FILTER From	      
  "messages from the given person"
  (SEARCH-FIELD FROM (PROMPT STRING "From")))

(DEFINE-FILTER Subject	      
  "messages with the given subject"
  (LET ((SUBJ (PROMPT STRING "Subject")))
    (OR (SEARCH-FIELD SUBJECT SUBJ)
	(SEARCH-FIELD RE SUBJ))))

(DEFINE-FILTER Recipient	      
  "messages with the given name in a recipient field"
  (LET ((RCPT (PROMPT STRING "Recipient")))
    (OR (SEARCH-FIELD TO RCPT) (SEARCH-FIELD CC RCPT))))


