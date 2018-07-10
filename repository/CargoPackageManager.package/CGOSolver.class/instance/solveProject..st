solving
solveProject: aProject 
	
	^ self solveDependency: (CGOPackageDependency 
		on: aProject packageName
		for: nil 
		withConstraints: { CGOFixedVersionConstraint with: aProject version } )