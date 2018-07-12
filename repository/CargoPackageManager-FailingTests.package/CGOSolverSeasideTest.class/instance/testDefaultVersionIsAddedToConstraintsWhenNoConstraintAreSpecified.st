tests
testDefaultVersionIsAddedToConstraintsWhenNoConstraintAreSpecified
	| resolution testPackage |
	testPackage := #'Seaside-Pharo-Flow'.
	
	resolution := solver solveDependency: (CGOPackageDependency on: testPackage for: nil).
	
	self 
		assert: (resolution ongoingPackageResolutionFor: testPackage) resolvedProjectVersion version
		equals: '3.1.0' asSemanticVersion

	
	