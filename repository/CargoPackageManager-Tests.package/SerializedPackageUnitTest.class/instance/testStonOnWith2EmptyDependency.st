tests
testStonOnWith2EmptyDependency
	| pkgUnit ston |
	pkgUnit := STON fromString: self a100With2EmptyDependency.
	ston := CGOPackageVersionWriter toStringPretty: pkgUnit.
	self
		assert: ston
		equals: self a100With2EmptyDependency