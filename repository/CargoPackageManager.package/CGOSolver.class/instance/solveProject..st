solving
solveProject: aProject
	
	| resolvedProject |
	resolvedProject := CGOResolvedProject onProject: aProject.
	aProject dependencies do: [ :each |
		resolvedProject addResolvedDependency: (CGOResolvedDependency
			onDependency: each
			resolution: (self solveProject: (each resolveInSolver: self))) ].
	^ resolvedProject