tests-querying
testVirtualPackageNamed
	| package |
	package := strategy virtualPackageNamed: #foo.
	self
		assert: (strategy virtualPackageNamed: #foo) == package
		description: 'Got 2 different object for the same package'.
	self
		assert: (package isKindOf: CGOVirtualPackage)
		description: 'Not a Virtual package!'