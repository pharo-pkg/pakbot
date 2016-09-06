versions fetching
packagesProviding: aName for: platformAttributes
	^ (CGOPackageVersion selectMany: [ :each | (each provisions = aName) ])
		select: [ :each | (each platformRequirements difference: platformAttributes) isEmpty ]
		thenCollect: #asString