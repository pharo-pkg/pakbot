tests - packages
testCanSolvePackageWithManyCompatibleConstraints
	| testPackage dependency version resolution |
	
	testPackage := #'Seaside-Core'.
	version := '3.1' asSemanticVersion.					
	dependency := CGOPackageDependency
						on: testPackage
						for: nil
						withConstraints: { CGOFixedVersionConstraint with: version . 
							CGOFixedVersionConstraint with: '3.1.0' asSemanticVersion }.

	resolution := solver solveDependency: dependency.
	
	self 
		assert: (resolution ongoingPackageResolutionFor: testPackage) resolvedProjectVersion version
		equals: version