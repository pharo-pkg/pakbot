versions fetching
fetch: aPackageName version: aVersion
	| packageFolder packageVersionString |
	packageFolder := self rootDirectory / aPackageName asLowercase.
	packageFolder exists
		ifFalse: [ CGOPackageNotFoundError signal: 'Cannot find ' , aPackageName , ' package' ].
	packageVersionString := aPackageName asLowercase, '@', aVersion asString.
	(packageFolder / packageVersionString) exists 
		ifTrue: [ ^ CGOPackageVersion fromStonString: (packageFolder / packageVersionString) contents ]
		ifFalse: [ CGOPackageVersionNotFoundError signal ] 
