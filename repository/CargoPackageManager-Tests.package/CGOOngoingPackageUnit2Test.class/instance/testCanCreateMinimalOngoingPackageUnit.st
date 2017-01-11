tests
testCanCreateMinimalOngoingPackageUnit
	| unit |
	unit := CGOOngoingPackageUnit2 for: #'Test'.
	
	self 
		assert: unit class 
		equals: CGOOngoingPackageUnit2 