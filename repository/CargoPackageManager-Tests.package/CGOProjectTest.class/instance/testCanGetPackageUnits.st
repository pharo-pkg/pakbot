tests
testCanGetPackageUnits
	| units |
	units := ongoingProject packageUnits.
	
	self assert: (units allSatisfy: #isUnit).