tests
testCanCreateMinimalOngoingPackageUnit
	| unit |
	unit := CGOOngoingPackageUnit for: #'Test'.
	
	self 
		assert: unit class 
		equals: CGOOngoingPackageUnit