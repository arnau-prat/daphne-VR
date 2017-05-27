(defglobal ?*p* = (new java.util.Vector))

(defrule CRITIQUE-PERFORMANCE::active-instr-in-orbit-DD
    (CAPABILITIES::can-measure (in-orbit ?o)(instrument ?instr) (orbit-RAAN ~DD))
    (CRITIQUE-PERFORMANCE-PARAM::list-of-active-instruments (list $?l))
    =>
    (if (numberp (member$ ?instr $?l)) then
    (call ?*p* addElement (new java.lang.String 
        (str-cat "Active instrument " ?instr " should not be in orbit " ?o )))))

(defrule CRITIQUE-PERFORMANCE::two-lidars-at-same-frequency-cannot-work
    "Two lidars at same frequency can interfere with each other"
    (CAPABILITIES::can-measure (in-orbit ?o)(instrument ?ins1) (can-take-measurements yes))
    (CAPABILITIES::can-measure (in-orbit ?o)(instrument ?ins2&~?ins1) (can-take-measurements yes))
    (DATABASE::Instrument (Name ?ins1) (Intent "Laser altimeters") (spectral-bands $?sr))
    (DATABASE::Instrument (Name ?ins2) (Intent "Laser altimeters") (spectral-bands $?sr))
    =>
    (call ?*p* addElement (new java.lang.String 
        (str-cat "Instruments "  ?ins1 " and " ?ins2 " should not be together"))))

(defrule CRITIQUE-PERFORMANCE::num-of-instruments
	(CRITIQUE-PERFORMANCE-PARAM::total-num-of-instruments (value ?v&:(> ?v 14)))
	=>
	(call ?*p* addElement (new java.lang.String 
        (str-cat "Too many instruments total: "?v))))

(defrule CRITIQUE-PERFORMANCE::resource-limitations-datarate
    (MANIFEST::Mission  (Name ?miss) (datarate-duty-cycle# ?dc&:(< ?dc 1.0)))
    =>
    (call ?*p* addElement (new java.lang.String  
        (str-cat "Cumulative spacecraft data rate in oribt " ?miss " is too big (" (format nil "%2.2f" ?dc) ")"))))

(defrule CRITIQUE-PERFORMANCE::resource-limitations-power
    "Technology to provide more than 10kW is currently expensive"
    (MANIFEST::Mission (Name ?miss) (power-duty-cycle# ?dc&:(< ?dc 1.0)))
    =>
    (call ?*p* addElement (new java.lang.String  
        (str-cat "Cumulative spacecraft power in orbit " ?miss " is  too big (" (format nil "%2.2f" ?dc) ")"))))

;(defrule CRITIQUE-PERFORMANCE::fairness-check
;    (CRITIQUE-PERFORMANCE-PARAM::fairness (flag 1) (value ?v)(stake-holder1 ?sh1) (stake-holder2 ?sh2))
;    =>
;    (call ?*p* addElement (new java.lang.String  
;        (str-cat "Satisfaction value for stakeholder " ?sh1 " is larger than " ?sh2 " (" (format nil "%2.2f" ?v) ")"))))
