versions fetching
packagesProviding: aName version: aSemanticVersion forEnvironment: platformAttributes
	| packages |
	
	packages := CGOPackageVersion selectMany: [ :each | 
		each isUnit 
		and: [ (each provides: (CGOPackageVersionReference packageName: aName version: aSemanticVersion))
		and: [ self does: each fitPlatformRequirements: platformAttributes ] ] ].
	^ packages collect: [ :each | each asString ]