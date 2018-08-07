Class {
	#name : #PBResolvedConflictDependencyState,
	#superclass : #PBAbstractDependencyState,
	#instVars : [
		'conflictingDependencies',
		'resolution'
	],
	#category : #'CargoPackageManager-Solver-Conflicts'
}

{ #category : #accessing }
PBResolvedConflictDependencyState >> conflictingDependencies: aCollection [ 
	conflictingDependencies := aCollection
]

{ #category : #testing }
PBResolvedConflictDependencyState >> isConflictingDependency [
	
	^ false
]

{ #category : #accessing }
PBResolvedConflictDependencyState >> resolution: aCGOResolvedProject [ 
	resolution := aCGOResolvedProject
]

{ #category : #resolution }
PBResolvedConflictDependencyState >> resolutionFor: aCGOResolvedDependency [ 
	
	^ resolution
]

{ #category : #resolving }
PBResolvedConflictDependencyState >> resolveWith: aCGOResolvedProject [ 
	resolution := aCGOResolvedProject.
	^ self
]
