tests
testNotUpToDateProjectOfferUpdateProjectRepairAction
	
	| repairActions |
	
	self deny: project isUpToDate.
	
	repairActions := CGORepairProjectAction allAvailableFor: project.
	
	self assert: (repairActions anySatisfy: [ :anAction | anAction isLoadProjectAction ])