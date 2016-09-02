initialization
initializeWith: aPackageVersionString
	packageName := (aPackageVersionString copyUpTo: self packageVersionSeparator) asSymbol.
	versionNumber := aPackageVersionString copyAfterLast: self packageVersionSeparator.
	packageRepositories := #()