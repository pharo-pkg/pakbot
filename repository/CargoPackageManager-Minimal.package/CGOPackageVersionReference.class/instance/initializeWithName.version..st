initialization
initializeWithName: aPackageName version: aVersionString
	packageName := aPackageName.
	versionNumber := aVersionString asSemanticVersion asString. "ensure semantic version is correct"
	packageRepositories := #()