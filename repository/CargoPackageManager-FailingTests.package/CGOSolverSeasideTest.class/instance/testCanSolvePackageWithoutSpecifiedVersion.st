tests - packages
testCanSolvePackageWithoutSpecifiedVersion
	| testPackage dependency resolution |
	
	testPackage := #'JQuery-Core'.
	dependency := CGOPackageDependency 
		on: testPackage
		for: nil
		withConstraints: #().
	
	resolution := solver solveDependency: dependency.
	
	self 
		assert: (resolution ongoingPackageResolutionFor: testPackage) resolvedProjectVersion version
		equals: '3.1.0' asSemanticVersion