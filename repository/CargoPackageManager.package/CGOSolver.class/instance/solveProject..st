solving
solveProject: aProject
	
	| resolvedProject dependencies |
	resolvedProject := CGOResolvedProject onProject: aProject.
	
	"Solve the project"
	aProject dependencies do: [ :each |
		resolvedProject addResolvedDependency: (CGOResolvedDependency
			onDependency: each
			resolution: (self solveProject: (each resolveInSolver: self))) ].
	
	"Check conflicts"
	dependencies := resolvedProject allResolvedDependencies.
	dependencies do: [ :each | 
		each
			checkConflictsWithDependencies: dependencies;
			checkConflictsWithRegistry: self registry ].
	^ resolvedProject