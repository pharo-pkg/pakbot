Class {
	#name : #PBDependencyConstraintTest,
	#superclass : #TestCase,
	#category : #'Pakbot-Tests-Dependencies'
}

{ #category : #tests }
PBDependencyConstraintTest >> testFromString [
	| dependency |
	dependency := PBDependencyConstraint fromString: '=1.0'.
	self 
		assert: dependency class
		equals: PBFixedVersionConstraint.
	self
		assert: dependency asString
		equals: '1.0'
]

{ #category : #tests }
PBDependencyConstraintTest >> testFromStringWithBadVersion [

	self assert: (PBDependencyConstraint fromString: '=foo') version isInvalid
]

{ #category : #tests }
PBDependencyConstraintTest >> testMergeAll [
	| c1 c2 result |
	
	c1 := PBFixedVersionConstraint with: '3.0' asSemanticVersion.
	c2 := PBFixedVersionConstraint with: '3.0' asSemanticVersion.
		
	result := (c2 mergeAll: { c1 . c1 }).
	self 
		assert: result
		equals: { c1 . c1 }.
		
	result := (c2 mergeAll: #()).
	self 
		assert: result
		equals: c2 asOrderedCollection
]
