tests
testCanCreateFromString
	| ref |
	ref := 'SomePackage@1.2' asPackageVersionReference.
	self 
		assert: ref packageName 
		equals: 'SomePackage'.
	self 
		assert: ref versionString
		equals: '1.2.0'.
	self 
		assert: ref versionNumber
		equals: '1.2.0' asSemanticVersion