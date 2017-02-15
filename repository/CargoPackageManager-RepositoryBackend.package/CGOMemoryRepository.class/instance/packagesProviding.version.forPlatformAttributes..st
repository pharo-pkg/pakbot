versions fetching
packagesProviding: aName version: aSemanticVersion forPlatformAttributes: platformAttributes
	| packages |
	
	packages := CGOPackageVersion selectMany: [ :each | 
		each isUnit 
		and: [ (each provides: (CGOPackageVersionReference packageName: aName version: aSemanticVersion))
		and: [ each platformRequirements includesAny: platformAttributes ] ] ].
	^ packages collect: [ :each | each asString ]