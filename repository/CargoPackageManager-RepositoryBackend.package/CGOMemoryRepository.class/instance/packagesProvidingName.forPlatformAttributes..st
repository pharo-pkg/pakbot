versions fetching
packagesProvidingName: aName forPlatformAttributes: platformAttributes
	^ CGOPackageVersion selectMany: [ :each | (each provides: aName) 
												and: [ (each platformRequirements difference: platformAttributes) isEmpty ] ]