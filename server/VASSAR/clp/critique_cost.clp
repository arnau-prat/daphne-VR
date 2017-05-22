(defglobal ?*q* = (new java.util.Vector))

(defrule CRITIQUE-COST::mass-check "limits the dry-mass of a satellite"
	(MANIFEST::Mission (Name ?n)(satellite-dry-mass ?sdm&:(> ?sdm 4000)))
	=>
        (call ?*q* addElement (new java.lang.String
	(str-cat ">> Satellite at orbit " ?n " is too heavy: dry-mass " ?sdm " kg"))))
	
	
(defrule CRITIQUE-COST::satellite-size-comparison
	(CRITIQUE-COST-PARAM::satellite-max-size-ratio (value ?r&:(> ?r 2.5)) (big-name ?bn) (small-name ?sn))
	=>
        (if (<> ?bn ?sn) then
        (call ?*q* addElement (new java.lang.String
	(str-cat ">> Satellites do not have similar sizes: satellite " ?bn " larger than " ?sn " (" (format nil "%2.2f" ?r) ")")))))

(defrule CRITIQUE-COST::satellite-cost-comparison
	(CRITIQUE-COST-PARAM::satellite-max-cost-ratio (value ?r&:(> ?r 2.5))(big-name ?bn) (small-name ?sn))
	=>
        (if (<> ?bn ?sn) then
        (call ?*q* addElement (new java.lang.String
	(str-cat ">> Satellites do not have similar costs: satellite " ?bn " more than " ?sn " (" (format nil "%2.2f" ?r) ")")))))
	
(defrule CRITIQUE-COST::launch-packaging-factors
	(CRITIQUE-COST-PARAM::launch-packaging-factors (name ?n)(performance-mass-ratio ?r-pm) (diameter-ratio ?r-dia) (height-ratio ?r-h))
	=>
	(bind ?m (min$ (create$ (bind ?f1 (- 1 ?r-pm)) (bind ?f2 (- 1 ?r-dia)) (bind ?f3 (- 1 ?r-h)))))
	(if (= ?m ?f1) then (bind ?lf "mass"))
	(if (= ?m ?f2) then (bind ?lf "diameter"))
	(if (= ?m ?f3) then (bind ?lf "height"))
	(if (> ?m 0.2)
	then (
        call ?*q* addElement (new java.lang.String
        (str-cat ">> The limiting factor among launch-packaging ratios of " ?n " is " ?lf ": "?m)))))
	