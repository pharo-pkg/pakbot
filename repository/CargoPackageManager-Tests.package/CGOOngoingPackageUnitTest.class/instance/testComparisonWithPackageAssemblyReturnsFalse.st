tests
testComparisonWithPackageAssemblyReturnsFalse
	| unit assembly |
	unit := (CGOOngoingPackageUnit for: #'Test').
	assembly := (CGOOngoingPackageAssembly for: 'Test').
	
	self deny: unit = assembly