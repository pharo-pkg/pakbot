tests
testFetchExactPackageVersionShouldReturnPackageVersionIfPresent
	| packageName version pkgVersion |
	
	packageName := 'Grease-Core'.
	version := '1.1.13'.
	
	pkgVersion := greaseRepository fetch: packageName version: version.
	
	self assert: (pkgVersion isKindOf: CGOPackageVersion).
	self assert: pkgVersion packageName equals: packageName.
	self assert: pkgVersion version equals: version asSemanticVersion.
