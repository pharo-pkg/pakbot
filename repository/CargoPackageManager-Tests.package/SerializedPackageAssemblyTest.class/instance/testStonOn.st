tests
testStonOn
	| serializedAssembly |
	serializedAssembly := self assemblyFoo asSerializedPackageVersion.
	serializedAssembly 
		instVarNamed: 'timestamp'
		put: (DateAndTime fuzzyReadFrom: '2015-02-26T12:17:20.505912+01:00' readStream).

	self
		assert: (CGOPackageVersionWriter toStringPretty: serializedAssembly)
		equals: self assemblyFooStonString