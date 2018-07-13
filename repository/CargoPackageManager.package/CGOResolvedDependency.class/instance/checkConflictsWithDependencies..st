conflicts
checkConflictsWithDependencies: aDependencyCollection
	
	| conflicts |
	conflicts := aDependencyCollection select: [ :each | each isConflictingWith: self ].
	dependencyState := dependencyState withConflicts: conflicts.