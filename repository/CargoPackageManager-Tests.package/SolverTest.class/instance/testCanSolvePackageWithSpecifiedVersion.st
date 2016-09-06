tests - packages
testCanSolvePackageWithSpecifiedVersion
	| testPackage dependency  version resolution |
	testPackage := #'JQuery-Core'.
	version := '3.1' asSemanticVersion.
	dependency := CGOPackageDependency 
		on: testPackage 
		for: nil
		withConstraints: {(CGOFixedVersionConstraint with: version)}.
	solver addConstraint: (CGOFixedVersionConstraint with: version) on: testPackage.
	
	resolution := solver solveDependency: dependency.
	
	self 
		assert: (resolution ongoingPackageResolutionFor: testPackage) packageVersion version
		equals: version