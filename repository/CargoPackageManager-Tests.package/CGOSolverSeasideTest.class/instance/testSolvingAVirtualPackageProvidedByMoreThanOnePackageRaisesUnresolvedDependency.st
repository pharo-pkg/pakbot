tests - virtual packages
testSolvingAVirtualPackageProvidedByMoreThanOnePackageRaisesUnresolvedDependency
	| dependency |
	
	dependency := CGOPackageDependency
						on: #'Seaside-Canvas-Platform'
						for: nil
						withConstraints: #().

	self 	
		should: [ solver solveDependency: dependency  ]
		raise: CGOUnresolvedDependency.
		
	