tests
testCanFetchPackageVersion
	| packageName version pkgVersion |
	
	packageName := 'Grease-Core'.
	version := '1.1.13'.
	
	pkgVersion := repository fetch: packageName version: version. "returns a CGOPackageVersion"
	
	self assert: (pkgVersion isKindOf: CGOPackageVersion).
	
	self 
		assert: pkgVersion packageName 
		equals: packageName.

	self 
		assert: pkgVersion version
		equals: version asSemanticVersion.
