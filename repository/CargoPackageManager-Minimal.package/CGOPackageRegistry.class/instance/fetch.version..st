compatilibility-repository
fetch: aPackageName version: aVersion
	
	| package |
	package := self packageNamed: aPackageName.
	package version = aVersion asSemanticVersion
		ifFalse: [ CGOPackageVersionNotFoundError signal ].
	^ package