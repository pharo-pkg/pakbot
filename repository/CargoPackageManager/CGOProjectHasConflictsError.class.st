Class {
	#name : #CGOProjectHasConflictsError,
	#superclass : #CGOPackageManagerError,
	#instVars : [
		'resolution'
	],
	#category : 'CargoPackageManager-Solver'
}

{ #category : #signalling }
CGOProjectHasConflictsError class >> signalOnResolution: aResolution [

	^ self new
		resolution: aResolution;
		signal
	
]

{ #category : #accessing }
CGOProjectHasConflictsError >> resolution: aCGOResolvedProject [ 
	resolution := aCGOResolvedProject
]
