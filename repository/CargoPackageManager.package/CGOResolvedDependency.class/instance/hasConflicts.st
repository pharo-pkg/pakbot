testing
hasConflicts
	
	^ dependencyState isConflictingDependency or: [ resolution hasConflicts ]