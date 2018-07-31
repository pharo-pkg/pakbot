Class {
	#name : #CGOResolvedConflictDependencyState,
	#superclass : #Object,
	#instVars : [
		'conflictingDependencies',
		'resolution'
	],
	#category : #'CargoPackageManager-Solver-Conflicts'
}

{ #category : #accessing }
CGOResolvedConflictDependencyState >> conflictingDependencies: aCollection [ 
	conflictingDependencies := aCollection
]

{ #category : #testing }
CGOResolvedConflictDependencyState >> isConflictingDependency [
	
	^ false
]

{ #category : #accessing }
CGOResolvedConflictDependencyState >> resolution: aCGOResolvedProject [ 
	resolution := aCGOResolvedProject
]

{ #category : #resolution }
CGOResolvedConflictDependencyState >> resolutionFor: aCGOResolvedDependency [ 
	
	^ resolution
]

{ #category : #resolving }
CGOResolvedConflictDependencyState >> resolveWith: aCGOResolvedProject [ 
	resolution := aCGOResolvedProject.
	^ self
]
