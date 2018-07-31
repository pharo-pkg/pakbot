Class {
	#name : #PBConflict,
	#superclass : #Object,
	#instVars : [
		'dependencies',
		'selectedResolution'
	],
	#category : #'CargoPackageManager-Solver'
}

{ #category : #'instance creation' }
PBConflict class >> onConflictingDependencies: aCollection [ 
	
	^ self new
		conflictingDependencies: aCollection;
		yourself
]

{ #category : #accessing }
PBConflict >> conflictingDependencies [
	^ dependencies 
]

{ #category : #accessing }
PBConflict >> conflictingDependencies: aCollection [ 
	dependencies := aCollection
]

{ #category : #accessing }
PBConflict >> dependencies [
	^ dependencies
]

{ #category : #testing }
PBConflict >> isResolved [
	
	^ selectedResolution isNotNil
]

{ #category : #accessing }
PBConflict >> possibleResolutions [
	^ (dependencies collect: [ :e | e originalResolution ]) asOrderedCollection.
]

{ #category : #accessing }
PBConflict >> projectName [
	^ dependencies anyOne projectName
]

{ #category : #testing }
PBConflict >> resolutionFor: aDependency [ 
	
	^ (dependencies detect: [ :each | each dependency = aDependency ]) resolution
]

{ #category : #resolving }
PBConflict >> resolveWithSelected [
	selectedResolution
		ifNotNil: [ dependencies do: [ :each | each resolveWith: selectedResolution ] ]
]

{ #category : #accessing }
PBConflict >> selectedResolution [

	^ selectedResolution
]

{ #category : #resolving }
PBConflict >> selectedResolution: aCGOResolvedProject [ 
	selectedResolution := aCGOResolvedProject
]
