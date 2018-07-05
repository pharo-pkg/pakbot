tests
testFetchExactPackageVersionShouldFailIfAbsentPackageName
	| packageName version |
	
	packageName := 'Grease-Core-Not-There'.
	version := '1.1.13'.
	
	self should: [ greaseRepository fetch: packageName version: version ] raise: CGOPackageNotFoundError