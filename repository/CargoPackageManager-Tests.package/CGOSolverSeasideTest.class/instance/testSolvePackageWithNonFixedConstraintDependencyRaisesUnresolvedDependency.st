tests
testSolvePackageWithNonFixedConstraintDependencyRaisesUnresolvedDependency
	| testPackage dependency |
	testPackage := #'JQuery-Core'.
	dependency := CGOPackageDependency 
		on: testPackage 
		for: nil
		withConstraints: { CGORangeVersionsConstraint between: '2.1' and: '2.4' }.
	
	self 
		should: [ solver solveDependency: dependency ]
		raise: CGOUnresolvedDependency.