versions fetching
packagesProviding: aName version: aSemanticVersion for: platformAttributes
	| packages |
	
	packages := CGOPackageVersion selectMany: [ :each | (each provides: aName) 
												and: [ each version = aSemanticVersion  
														and: [ each platformRequirements includesAny: platformAttributes ] ] ].
	^ packages collect: [ :each | each asString ]