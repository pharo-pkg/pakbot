tests
testProjectRegisteredWhenPackageUnitIsAdded
	| project unit |
	project := CGOOngoingProject example.
	unit := project packageUnits anyOne.
	
	registry register: unit.
	
	self 
		assert: registry registeredProjects size
		equals: 1.