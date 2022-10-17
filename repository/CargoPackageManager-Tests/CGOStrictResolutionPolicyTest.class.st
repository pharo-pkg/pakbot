Class {
	#name : #CGOStrictResolutionPolicyTest,
	#superclass : #TestCase,
	#category : #'CargoPackageManager-Tests'
}

{ #category : #tests }
CGOStrictResolutionPolicyTest >> testMergeStrictResolutionPolicy [
	| constraint1 constraint2 |
	
	constraint1 := PBDependencyConstraint fromString: '=1.0'.
	self
		assert: (constraint1 mergeFixedVersionConstraint: constraint1)
		equals: constraint1.
	
	constraint2 := PBFixedVersionConstraint fromString: '=1.0'.
	self
		assert: (constraint1 mergeFixedVersionConstraint: constraint2)
		equals: constraint2.

	constraint2 := PBFixedVersionConstraint fromString: '=1.1'.
	self
		should: [ constraint1 mergeFixedVersionConstraint: constraint2 ]
		raise: CGODependencyConflictError.
]
