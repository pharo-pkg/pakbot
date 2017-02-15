versions fetching
fetchVirtual: aVirtualPackageName version: aVersion
	^ (CGOPackageVersion selectOne: 
		[ :each | 
		(each packageName = aVirtualPackageName) and: [ each version = aVersion asSemanticVersion ] ])
			ifNil: [ CGOPackageVersionNotFoundError signal ]