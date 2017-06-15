initialization
initializeWith: aPackageVersionString
	packageName := (aPackageVersionString copyUpTo: self class packageVersionSeparator) asSymbol.
	version := (aPackageVersionString copyAfterLast: self class packageVersionSeparator).
	version ifNotEmpty: [ version := version asSemanticVersion asString ].
	packageRepositories := #()