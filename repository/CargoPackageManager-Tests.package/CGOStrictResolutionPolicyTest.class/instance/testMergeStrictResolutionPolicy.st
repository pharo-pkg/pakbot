tests
testMergeStrictResolutionPolicy
	| constraint1 constraint2 |
	
	constraint1 := CGODependencyConstraint fromString: '=1.0'.
	self
		assert: (constraint1 mergeFixedVersionConstraint: constraint1)
		equals: constraint1.
	
	constraint2 := CGOFixedVersionConstraint fromString: '=1.0'.
	self
		assert: (constraint1 mergeFixedVersionConstraint: constraint2)
		equals: constraint2.

	constraint2 := CGOFixedVersionConstraint fromString: '=1.1'.
	self
		should: [ constraint1 mergeFixedVersionConstraint: constraint2 ]
		raise: CGODependencyConflictError.