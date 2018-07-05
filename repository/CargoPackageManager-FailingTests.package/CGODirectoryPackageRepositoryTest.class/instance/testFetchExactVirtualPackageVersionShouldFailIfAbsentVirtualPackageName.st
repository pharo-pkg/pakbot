tests
testFetchExactVirtualPackageVersionShouldFailIfAbsentVirtualPackageName
	| packageName version |
	
	packageName := 'Grease-Slime-Not-There'.
	version := '1'.
	
	self 
		should: [ greaseRepository fetch: packageName version: version ]
		raise: CGOPackageNotFoundError