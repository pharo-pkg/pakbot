tests
testProjectUnregisteredWhenPackageUnitIsUnregistered
	| project unit |
	project := CGOOngoingProject example.
	unit := project packageUnits anyOne.
	registry register: unit.
	
	registry unregister: unit.
	
	self 
		assert: registry registeredProjects isEmpty.