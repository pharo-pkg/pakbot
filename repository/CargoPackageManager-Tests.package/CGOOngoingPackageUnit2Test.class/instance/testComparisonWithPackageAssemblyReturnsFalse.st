tests
testComparisonWithPackageAssemblyReturnsFalse
	| unit assembly |
	unit := (CGOOngoingPackageUnit2 for: #'Test').
	assembly := (CGOOngoingPackageAssembly2 for: 'Test').
	
	self deny: unit = assembly