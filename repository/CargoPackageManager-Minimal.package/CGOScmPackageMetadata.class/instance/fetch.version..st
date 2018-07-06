versions fetching
fetch: aPackageName version: aVersion
	| package version |
	package := self package: aPackageName.
	
	(aVersion beginsWith: '0.0.0-')
		ifFalse: [ CGOPackageVersionNotFoundError signal ].
	version := aVersion allButFirst: 6. "Remove useless version number 0.0.0 as ti comes from SCM"
	(version at: 1) = $# ifTrue: [ version := version allButFirst asSymbol ].
	
	^ ((package version = aVersion asSemanticVersion) or: [ package version = version ])
 		ifTrue: [ package ]
		ifFalse: [ CGOPackageVersionNotFoundError signal ]