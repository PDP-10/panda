; Logical name definitions to compile CHIVES on Panda.
; Where the sources currently live
define CHIVES_SOURCE:	PS:<CHIVES.V1.SOURCE>
;
; Where monitor universal files live (for GTDOM/UGTDOM)
define MONITOR_UNIVERSALS: PS:<7-1-MONITOR>
;
; Search paths built out of the preceeding
define DSK: DSK:,CHIVES_SOURCE:
define UNV: DSK:,MONITOR_UNIVERSALS:,UNV:
