versions fetching
fetchVirtual: aVirtualPackageName version: aVersion
	| packageFolder packageVersionString |
	packageFolder := self virtualDirectory / aVirtualPackageName asLowercase.
	packageFolder exists
		ifFalse: [ CGOPackageNotFoundError signal: aVirtualPackageName ].
	packageVersionString := aVirtualPackageName asLowercase, '@', aVersion asSemanticVersion asString.
	(packageFolder / packageVersionString) exists 
		ifTrue: [ ^ CGOVirtualPackageVersion fromStonString: (packageFolder / packageVersionString) contents ]
		ifFalse: [ CGOPackageVersionNotFoundError signal ] 
