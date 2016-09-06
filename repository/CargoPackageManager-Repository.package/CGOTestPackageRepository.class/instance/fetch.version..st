versions fetching
fetch: aPackageName version: aVersion
	^ packages 
		detect: [ :package | (package packageName = aPackageName) and: [ package version = aVersion ]  ]
		ifNone: [ CGOPackageVersionNotFoundError signal ]