tests - packages
testSolvingADependencyWithATransitiveDependencySolvesBothDependencies
	| dependencyToSolve resolution |
	dependencyToSolve := CGOPackageDependency 
								on: 'Seaside-Flow-Platform'
								for: nil
								withConstraints: { CGOFixedVersionConstraint with: '1' }.
	
	resolution := solver solveDependency: dependencyToSolve.

	self 
		assert: resolution resolvedVersions size 
		equals: 2