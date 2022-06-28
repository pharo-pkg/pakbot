"
I represent a dependency that had conflicts and that has been manually resolved by the user, i.e. the conflict is now solved.

"
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
PBResolvedConflictDependencyState >> resolutionFor: aPBResolvedDependency [ 
	
	^ resolution
]

{ #category : #resolving }
PBResolvedConflictDependencyState >> resolveWith: aCGOResolvedProject [ 
	resolution := aCGOResolvedProject.
	^ self
]
