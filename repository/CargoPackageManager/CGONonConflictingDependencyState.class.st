Class {
	#name : #CGONonConflictingDependencyState,
	#superclass : #Object,
	#category : #'CargoPackageManager-Solver-Conflicts'
}

{ #category : #accessing }
CGONonConflictingDependencyState >> conflictingDependencies [
	
	^ #()
]

{ #category : #accessing }
CGONonConflictingDependencyState >> conflictingDependenciesFor: aResolvedDependency [

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
