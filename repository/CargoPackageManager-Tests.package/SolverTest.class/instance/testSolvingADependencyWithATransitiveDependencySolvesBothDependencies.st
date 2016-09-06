tests - packages
testSolvingADependencyWithATransitiveDependencySolvesBothDependencies
	| dependencyToSolve resolution |
	dependencyToSolve := CGOPackageDependency 
								on: 'Seaside-Flow-Platform'
								for: nil
								withConstraints: { CGOFixedVersionConstraint with: '3.1' }.
	
	resolution := solver solveDependency: dependencyToSolve.

	self 
		assert: resolution resolvedDependencies size 
		equals: 2