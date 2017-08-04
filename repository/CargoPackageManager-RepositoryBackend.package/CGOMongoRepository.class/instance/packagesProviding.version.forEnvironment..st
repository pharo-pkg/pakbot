versions fetching
packagesProviding: aName version: aSemanticVersion forEnvironment: platformAttributes
	| virtualPkgVersionRef packages |
	
	virtualPkgVersionRef := CGOPackageVersionReference 
			packageName: aName 
			version: aSemanticVersion.
	packages := CGOPackageVersion selectMany: 
					[ :each | each provisions includes: virtualPkgVersionRef asString ].
	^ packages 
		select: [ :each | (each platformRequirements difference: platformAttributes) isEmpty ]
		thenCollect: #asString