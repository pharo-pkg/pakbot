instance creation
repositoryUrl: aStringOrUrl packageName: aString versionString: aVersionString
	^ self basicNew 
		repositoryUrl: aStringOrUrl asUrl packageName: aString versionString: aVersionString;
		yourself