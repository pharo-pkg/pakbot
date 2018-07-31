Class {
	#name : #CGOConflictingDependencyState,
	#superclass : #Object,
	#instVars : [
		'conflictingDependencies'
	],
	#category : #'CargoPackageManager-Solver-Conflicts'
}

{ #category : #'instance-creation' }
CGOConflictingDependencyState class >> withConflicts: aCollection [
	
	^ self new
		conflictingDependencies: aCollection;
		yourself
]

{ #category : #accessing }
CGOConflictingDependencyState >> conflictingDependencies [
	^ conflictingDependencies
]

{ #category : #accessing }
CGOConflictingDependencyState >> conflictingDependencies: aCollection [ 
	conflictingDependencies := aCollection
]

{ #category : #accessing }
CGOConflictingDependencyState >> conflictingDependenciesFor: aResolvedDependency [

	^ { aResolvedDependency } , conflictingDependencies asOrderedCollection
]

{ #category : #testing }
CGOConflictingDependencyState >> isConflictingDependency [
	
	^ true
]

{ #category : #resolution }
CGOConflictingDependencyState >> resolutionFor: aCGOResolvedDependency [ 
	
	^ aCGOResolvedDependency originalResolution
]

{ #category : #resolving }
CGOConflictingDependencyState >> resolveWith: aCGOResolvedProject [ 
	
	^ CGOResolvedConflictDependencyState new
		conflictingDependencies: conflictingDependencies;
		resolution: aCGOResolvedProject;
		yourself.
]

{ #category : #transitioning }
CGOConflictingDependencyState >> withConflicts: aCollection [ 
	
	^ self class withConflicts: conflictingDependencies , aCollection
]
