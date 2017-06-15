utility
assertPackage: aPackage equals: aPackageVersionString
	| anotherPackage |
	
	anotherPackage := aPackageVersionString asPackageVersionReference.
	
	self assert: aPackage packageName equals: anotherPackage packageName.
	self assert: aPackage version equals: anotherPackage versionNumber.