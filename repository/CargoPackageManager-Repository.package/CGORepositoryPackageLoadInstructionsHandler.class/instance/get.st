public
get
	| dependency resolution sorter |
	dependency := CGOPackageDependency
						on: (CGOPackage named: variables first)
						for: nil
						withConstraints: { CGOFixedVersionConstraint with: variables second }.
	resolution := CGOSolver new solveDependency: dependency.
	sorter := CGOLoadInstructionsBuilder new
					resolution: resolution;
					yourself.
	^ self stonResponse: sorter loadInstructions