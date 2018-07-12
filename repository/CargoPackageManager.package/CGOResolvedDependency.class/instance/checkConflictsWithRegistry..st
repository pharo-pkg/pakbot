conflicts
checkConflictsWithRegistry: aCGOPackageRegistry

	| conflicts |
	conflicts := aCGOPackageRegistry registeredProjects select: [ :each | each isConflictingWith: self ].
	dependencyState := dependencyState withConflicts: conflicts.