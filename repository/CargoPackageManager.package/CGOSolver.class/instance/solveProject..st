solving
solveProject: aProject
	
	resolution addOriginDependency: aProject .
	^ self solveDependency: aProject