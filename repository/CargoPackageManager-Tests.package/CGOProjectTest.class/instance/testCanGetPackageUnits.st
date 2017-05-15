tests
testCanGetPackageUnits
	| units |
	units := ongoingProject packageUnitNames.
	
	self assert: (units allSatisfy: #isUnit).