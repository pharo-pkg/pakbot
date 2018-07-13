tests - virtual packages
testCanSolveVirtualPackageWithoutSpecifiedVersion
	| testPackage dependency resolution packageVersion |
	
	testPackage := #'Seaside-Continuation-Platform'.
	dependency := CGOPackageDependency
						on: testPackage
						for: nil
						withConstraints: #().

	resolution := solver solveDependency: dependency.
	packageVersion := (resolution ongoingPackageResolutionFor: testPackage) resolvedProjectVersion.
	
	self
		assert: packageVersion packageName
		equals: 'Seaside-Pharo-Continuation'.
	self
		assert: packageVersion version
		equals: '3.1' asSemanticVersion