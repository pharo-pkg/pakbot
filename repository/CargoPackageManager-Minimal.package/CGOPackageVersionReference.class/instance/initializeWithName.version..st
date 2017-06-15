initialization
initializeWithName: aPackageName version: aVersionOrVersionString
	packageName := aPackageName.
	version := aVersionOrVersionString asString.
	version ifNotEmpty: 
		[ version asSemanticVersion asString  "ensure semantic version is correct" ].
	packageRepositories := #()