conflicts
isConflictingWith: aCGOResolvedDependency 
	
	^ (self name = aCGOResolvedDependency name)
		and: [ self ~= aCGOResolvedDependency resolution resolvedProjectVersion ]