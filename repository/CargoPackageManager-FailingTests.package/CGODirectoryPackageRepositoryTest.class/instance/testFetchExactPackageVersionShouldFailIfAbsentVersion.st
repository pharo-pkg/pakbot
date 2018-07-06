tests
testFetchExactPackageVersionShouldFailIfAbsentVersion
	| packageName version |
	
	packageName := 'Grease-Core'.
	version := '1.1.13-absentVersion'.
	
	self should: [ greaseRepository fetch: packageName version: version ] raise: CGOPackageVersionNotFoundError