"
I represent a dependency conflicting with another project installation or dependency
"
Class {
	#name : #PBConflictingDependencyState,
	#superclass : #PBAbstractDependencyState,
	#instVars : [
		'conflictingDependencies'
	],
	#category : #'Pakbot-Core-Solver-Conflicts'
}

{ #category : #'instance-creation' }
PBConflictingDependencyState class >> withConflicts: aCollection onDependency: dependency [
	
	^ (self onDependency: dependency)
		conflictingDependencies: aCollection;
		yourself
]

{ #category : #accessing }
PBConflictingDependencyState >> conflictingDependencies [
	^ conflictingDependencies
]

{ #category : #accessing }
PBConflictingDependencyState >> conflictingDependencies: aCollection [ 
	conflictingDependencies := aCollection
]

{ #category : #accessing }
PBConflictingDependencyState >> conflictingDependenciesFor: aResolvedDependency [

	^ { aResolvedDependency } , conflictingDependencies asOrderedCollection
]

{ #category : #testing }
PBConflictingDependencyState >> isConflictingDependency [
	
	^ true
]

{ #category : #resolution }
PBConflictingDependencyState >> resolutionFor: aPBResolvedDependency [ 
	
	^ aPBResolvedDependency originalResolution
]

{ #category : #resolving }
PBConflictingDependencyState >> resolveWith: aCGOResolvedProject [ 
	
	^ (PBResolvedConflictDependencyState onDependency: dependency)
		conflictingDependencies: conflictingDependencies;
		resolution: aCGOResolvedProject;
		yourself.
]

{ #category : #transitioning }
PBConflictingDependencyState >> withConflicts: aCollection [ 
	
	^ self class withConflicts: conflictingDependencies , aCollection onDependency: dependency
]
