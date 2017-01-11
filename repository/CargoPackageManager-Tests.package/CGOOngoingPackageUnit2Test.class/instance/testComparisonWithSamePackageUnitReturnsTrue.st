tests
testComparisonWithSamePackageUnitReturnsTrue
	| unit |
	unit := (CGOOngoingPackageUnit2 for: #'Test').
	
	self 
		assert: unit 
		equals: unit copy