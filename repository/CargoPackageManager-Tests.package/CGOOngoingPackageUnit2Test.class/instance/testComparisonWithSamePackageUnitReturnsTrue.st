tests
testComparisonWithSamePackageUnitReturnsTrue
	| unit |
	unit := (CGOOngoingPackageUnit for: #'Test').
	
	self 
		assert: unit 
		equals: unit copy