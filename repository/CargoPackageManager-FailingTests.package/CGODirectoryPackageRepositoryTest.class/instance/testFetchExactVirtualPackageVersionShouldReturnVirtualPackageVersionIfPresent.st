tests
testFetchExactVirtualPackageVersionShouldReturnVirtualPackageVersionIfPresent
	| packageName version pkgVersion |
	
	packageName := 'Grease-Slime'.
	version := '1'.
	
	pkgVersion := greaseRepository fetchVirtual: packageName version: version.
	
	self assert: (pkgVersion isKindOf: CGOVirtualPackageVersion).
	self assert: pkgVersion packageName equals: packageName.
	self assert: pkgVersion version equals: version asSemanticVersion.
