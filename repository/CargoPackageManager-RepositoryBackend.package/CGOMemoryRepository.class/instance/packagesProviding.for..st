versions fetching
packagesProviding: aName for: platformAttributes
	^ CGOPackageVersion selectMany: [ :each | (each provides: aName) 
												and: [ (each platformRequirements difference: platformAttributes) isEmpty ] ]