tests-querying
testPackageNamed
	| package |
	package := strategy packageNamed: #foo.
	
	self
		assert: (strategy packageNamed: #foo) == package
		description: 'Got 2 different object for the same package'
		