versions fetching
packagesProvidingName: aName forPlatformAttributes: platformAttributes
	^ (CGOPackageVersion selectMany: [ :each | (each provisions = aName) ])
		select: [ :each | (each platformRequirements difference: platformAttributes) isEmpty ]
		thenCollect: #asString