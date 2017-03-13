initialization
initializeWith: aPackageVersionString
	packageName := (aPackageVersionString copyUpTo: self class packageVersionSeparator) asSymbol.
	versionNumber := (aPackageVersionString copyAfterLast: self class packageVersionSeparator).
	versionNumber ifNotEmpty: [ versionNumber := versionNumber asSemanticVersion asString ].
	packageRepositories := #()