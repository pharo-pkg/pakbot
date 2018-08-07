Class {
	#name : #PBConflictingDependencyState,
	#superclass : #PBAbstractDependencyState,
	#instVars : [
		'conflictingDependencies'
	],
	#category : #'CargoPackageManager-Solver-Conflicts'
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
PBConflictingDependencyState >> resolutionFor: aCGOResolvedDependency [ 
	
	^ aCGOResolvedDependency originalResolution
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
