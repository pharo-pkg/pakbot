versions fetching
bleedingEdgeOfConcretePackage: aPackageName for: platformAttributes
	| candidates packageId |
	
	packageId := self packageVoyageId: aPackageName.
	candidates := CGOPackageVersion selectMany: [ :each | (each at: 'package.__id') = packageId ].
	^ ((candidates 
		select: [ :each | (each platformRequirements difference: platformAttributes) isEmpty ])
			detectMax: #version) asPackageVersionReference