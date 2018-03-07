tests
testProjectStillRegisteredWhenPackageUnitIsUnregisteredAndSomeOfItsPackageStillInstalled
	| project unit unit2 |
	project := CGOOngoingProject example.
	unit := project packageUnits anyOne.
	unit2 := project newPackageUnit: #Unit2.
	registry register: unit.
	registry register: unit2.
	
	registry unregister: unit.
	
	self 
		assert: registry registeredProjects size 
		equals: 1