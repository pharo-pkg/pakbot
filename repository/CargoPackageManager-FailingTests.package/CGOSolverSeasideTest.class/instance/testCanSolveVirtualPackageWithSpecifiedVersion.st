tests - virtual packages
testCanSolveVirtualPackageWithSpecifiedVersion
	| testPackage version dependency resolution packageVersion |
	
	testPackage := #'Seaside-Canvas-Platform'.
	version := '1.0' asSemanticVersion.					
	dependency := CGOPackageDependency
						on: testPackage
						for: nil
						withConstraints: { CGOFixedVersionConstraint with: version }.

	resolution := solver solveDependency: dependency.
	packageVersion := (resolution ongoingPackageResolutionFor: testPackage) resolvedProjectVersion.
	
	self
		assert: packageVersion packageName
		equals: 'Seaside-Pharo-Canvas'.
	self
		assert: packageVersion version
		equals: '3.1' asSemanticVersion
