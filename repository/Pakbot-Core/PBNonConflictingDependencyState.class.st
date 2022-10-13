"
I represent a dependency that has no conflict with anything
"
Class {
	#name : #PBNonConflictingDependencyState,
	#superclass : #PBAbstractDependencyState,
	#category : #'Pakbot-Core-Solver-Conflicts'
}

{ #category : #accessing }
PBNonConflictingDependencyState >> conflictingDependencies [
	
	^ #()
]

{ #category : #accessing }
PBNonConflictingDependencyState >> conflictingDependenciesFor: aResolvedDependency [

	^ #()
]

{ #category : #testing }
PBNonConflictingDependencyState >> isConflictingDependency [
	
	^ false
]

{ #category : #resolution }
PBNonConflictingDependencyState >> resolutionFor: aPBResolvedDependency [ 
	
	^ aPBResolvedDependency originalResolution
]

{ #category : #updating }
PBNonConflictingDependencyState >> withConflicts: aCollection [ 
	
	aCollection ifEmpty: [ ^ self ].
	^ PBConflictingDependencyState withConflicts: aCollection onDependency: dependency
]
