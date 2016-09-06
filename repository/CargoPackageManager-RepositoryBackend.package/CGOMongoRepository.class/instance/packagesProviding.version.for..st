versions fetching
packagesProviding: aName version: aSemanticVersion for: platformAttributes
	| packages |
	
	packages := CGOPackageVersion selectMany: 
					[ :each | (each provisions = aName) 
					& (each version = aSemanticVersion asString) ].
	^ packages 
		select: [ :each | (each platformRequirements difference: platformAttributes) isEmpty ]
		thenCollect: #asString