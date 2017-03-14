versions fetching
fetch: aPackageName version: aVersion
	^ packageVersions 
		detect: [ :each | 
					(each packageName = aPackageName) and: [ each version = aVersion asSemanticVersion ] ]
		ifNone: [ CGOPackageVersionNotFoundError signal ]