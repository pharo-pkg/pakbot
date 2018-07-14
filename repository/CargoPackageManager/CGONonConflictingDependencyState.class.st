Class {
	#name : #CGONonConflictingDependencyState,
	#superclass : #Object,
	#category : 'CargoPackageManager-Solver'
}

{ #category : #accessing }
CGONonConflictingDependencyState >> conflictingDependencies [
	
	^ #()
]

{ #category : #testing }
CGONonConflictingDependencyState >> isConflictingDependency [
	
	^ false
]

{ #category : #updating }
CGONonConflictingDependencyState >> withConflicts: aCollection [ 
	
	aCollection ifEmpty: [ ^ self ].
	^ CGOConflictingDependencyState withConflicts: aCollection
]
