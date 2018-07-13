conflicts
isConflictingWith: aCGOResolvedDependency 
	
	^ (self dependency isSameProjectAs: aCGOResolvedDependency dependency)
		and: [ (resolution = aCGOResolvedDependency resolution) not ]