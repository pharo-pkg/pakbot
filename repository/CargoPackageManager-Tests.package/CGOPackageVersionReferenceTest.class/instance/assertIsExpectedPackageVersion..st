tests
assertIsExpectedPackageVersion: packageVersion
	self assert: packageVersion notNil.
	self assert: (packageVersion isKindOf: CGOPackageVersion).
	self assert: packageVersion packageName equals: pkgVersionReference packageName.
	self assert: packageVersion version equals: pkgVersionReference versionNumber asSemanticVersion