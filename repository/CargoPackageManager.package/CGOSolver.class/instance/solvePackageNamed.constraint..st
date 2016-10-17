protocol
solvePackageNamed: aPackageName constraint: aConstraint
	
	^ self solveDependency: (CGOPackageDependency on: aPackageName for: nil withConstraints: {aConstraint} )