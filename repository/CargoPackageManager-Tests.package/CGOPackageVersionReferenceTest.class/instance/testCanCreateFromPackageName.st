tests
testCanCreateFromPackageName
	| ref |
	ref := 'SomePackage' asPackageVersionReference.
	self 
		assert: ref packageName 
		equals: 'SomePackage'.
	self 
		assert: ref versionString
		equals: ''.
	self 
		assert: ref versionNumber
		equals: nil