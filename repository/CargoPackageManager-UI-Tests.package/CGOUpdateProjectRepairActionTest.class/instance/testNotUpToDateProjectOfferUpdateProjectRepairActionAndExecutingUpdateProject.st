tests
testNotUpToDateProjectOfferUpdateProjectRepairActionAndExecutingUpdateProject
	
	| repairActions action |
		
	repairActions := CGORepairProjectAction allAvailableFor: project.	
	action := repairActions detect: [ :anAction | anAction isLoadProjectAction ].

	action execute.
	
	self assert: project isUpToDate.