tests - virtual packages
testSolvingAVirtualPackageProvidedByNoPackageRaisesUnresolvedDependency
	| dependency |
	
	dependency := CGOPackageDependency
						on: #'Seaside-Canvas-Platform'
						for: nil
						withConstraints: { CGOFixedVersionConstraint with: '99.5' }.

	self 	
		should: [ solver solveDependency: dependency  ]
		raise: CGOUnresolvedDependency.
		
	