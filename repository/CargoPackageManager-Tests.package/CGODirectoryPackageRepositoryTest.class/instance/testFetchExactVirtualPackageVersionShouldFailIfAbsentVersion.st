tests
testFetchExactVirtualPackageVersionShouldFailIfAbsentVersion
	| packageName version |
	
	packageName := 'Grease-Slime'.
	version := '2.0-absentVersion'.
	
	self 
		should: [ greaseRepository fetchVirtual: packageName version: version ]
		raise: CGOPackageVersionNotFoundError