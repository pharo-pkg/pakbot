tests
testProjectStillRegisteredWhenPackageUnitIsUnregisteredAndSomeOfItsPackageStillInstalled
	| project unit unit2 |
	project := CGOOngoingProject example.
	project registry: registry.
	unit := project packageUnits anyOne.
	registry register: unit.
	unit2 := project newPackageUnit: #Unit2. "registers #Unit2"
	
	registry unregister: unit.
	
	self 
		assert: registry registeredProjects size 
		equals: 1