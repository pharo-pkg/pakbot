conflicts
checkConflictsWithRegistry: aCGOPackageRegistry

	| conflicts |
	conflicts := aCGOPackageRegistry conflictingProjectsWith: self.
	dependencyState := dependencyState withConflicts: conflicts.