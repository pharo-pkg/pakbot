tests
testPackageRegisteredWhenPackageUnitIsAdded
	| project unit |
	project := CGOOngoingProject example.
	unit := project packageUnits anyOne.
	
	registry register: unit.
	
	self 
		assert: registry installedPackages size
		equals: 1.