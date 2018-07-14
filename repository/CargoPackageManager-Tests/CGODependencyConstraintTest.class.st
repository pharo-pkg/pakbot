Class {
	#name : #CGODependencyConstraintTest,
	#superclass : #CGOTest,
	#category : 'CargoPackageManager-Tests-Model'
}

{ #category : #accessing }
CGODependencyConstraintTest class >> resources [
	^ #()
]

{ #category : #tests }
CGODependencyConstraintTest >> testFromString [
	| dependency |
	dependency := CGODependencyConstraint fromString: '=1.0'.
	self 
		assert: dependency class
		equals: CGOFixedVersionConstraint.
	self
		assert: dependency asString
		equals: '=1.0.0'
]

{ #category : #tests }
CGODependencyConstraintTest >> testFromStringWithBadValue [
	self
		should: [ CGODependencyConstraint fromString: 'foo' ]
		raise: CGODependencyConstraintFormatError
]

{ #category : #tests }
CGODependencyConstraintTest >> testFromStringWithBadVersion [
	self
		should: [ CGODependencyConstraint fromString: '=foo' ]
		raise: SemanticVersionFormatError
]

{ #category : #tests }
CGODependencyConstraintTest >> testMergeAll [
	| c1 c2 result |
	
	c1 := CGOFixedVersionConstraint with: '3.0' asSemanticVersion.
	c2 := CGOFixedVersionConstraint with: '3.0' asSemanticVersion.
		
	result := (c2 mergeAll: { c1 . c1 }).
	self 
		assert: result
		equals: { c1 . c1 }.
		
	result := (c2 mergeAll: #()).
	self 
		assert: result
		equals: c2 asOrderedCollection
]
