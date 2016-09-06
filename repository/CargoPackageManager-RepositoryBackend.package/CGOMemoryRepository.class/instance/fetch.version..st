versions fetching
fetch: aPackageName version: aVersion
	^ (CGOPackageVersion selectOne: 
		[ :each | 
		(each packageName = aPackageName) and: [ each version = aVersion asSemanticVersion ] ])
			ifNil: [ CGOPackageVersionNotFoundError signal ]