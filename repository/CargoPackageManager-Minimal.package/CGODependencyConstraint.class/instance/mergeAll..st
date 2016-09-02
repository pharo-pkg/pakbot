merging
mergeAll: aDependencyConstraintsList
	^ aDependencyConstraintsList 
		ifEmpty: [ self asOrderedCollection ]
		ifNotEmpty: [ aDependencyConstraintsList collect: [ :aConstraint | aConstraint merge: self ] ]