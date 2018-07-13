testing
hasConflicts
	
	^ self resolvedDependencies anySatisfy: [ :any | any hasConflicts ]