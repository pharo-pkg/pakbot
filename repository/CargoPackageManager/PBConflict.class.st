Class {
	#name : #PBConflict,
	#superclass : #Object,
	#instVars : [
		'dependencies'
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
PBConflict >> projectName [
	^ dependencies anyOne projectName
]
