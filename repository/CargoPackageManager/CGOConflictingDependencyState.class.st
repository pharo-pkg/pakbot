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

{ #category : #transitioning }
CGOConflictingDependencyState >> withConflicts: aCollection [ 
	
	^ self class withConflicts: conflictingDependencies , aCollection
]
