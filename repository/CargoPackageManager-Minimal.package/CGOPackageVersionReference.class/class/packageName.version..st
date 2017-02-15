instance creation
packageName: aPackageName version: aVersionString
	^ self new
		initializeWithName: aPackageName version: aVersionString;
		yourself