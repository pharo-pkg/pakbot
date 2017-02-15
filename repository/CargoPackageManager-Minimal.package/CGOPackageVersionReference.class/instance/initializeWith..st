initialization
initializeWith: aPackageVersionString
	packageName := (aPackageVersionString copyUpTo: self packageVersionSeparator) asSymbol.
	versionNumber := (aPackageVersionString copyAfterLast: self packageVersionSeparator).
	versionNumber ifNotEmpty: [ versionNumber := versionNumber asSemanticVersion asString ].
	packageRepositories := #()