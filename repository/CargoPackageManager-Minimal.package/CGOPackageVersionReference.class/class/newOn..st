instance creation
newOn: aPackageVersionString
	^ self new
		initializeWith: aPackageVersionString;
		yourself