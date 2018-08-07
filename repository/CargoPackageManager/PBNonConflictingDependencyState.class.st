Class {
	#name : #PBNonConflictingDependencyState,
	#superclass : #PBAbstractDependencyState,
	#category : #'CargoPackageManager-Solver-Conflicts'
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
PBNonConflictingDependencyState >> resolutionFor: aCGOResolvedDependency [ 
	
	^ aCGOResolvedDependency originalResolution
]

{ #category : #updating }
PBNonConflictingDependencyState >> withConflicts: aCollection [ 
	
	aCollection ifEmpty: [ ^ self ].
	^ PBConflictingDependencyState withConflicts: aCollection onDependency: dependency
]
