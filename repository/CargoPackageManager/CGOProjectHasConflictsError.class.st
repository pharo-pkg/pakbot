Class {
	#name : #CGOProjectHasConflictsError,
	#superclass : #PBError,
	#instVars : [
		'resolution'
	],
	#category : #'CargoPackageManager-Solver'
}

{ #category : #signalling }
CGOProjectHasConflictsError class >> signalOnResolution: aResolution [

	^ self new
		resolution: aResolution;
		signal
	
]

{ #category : #accessing }
CGOProjectHasConflictsError >> messageText [
	^ 'There are conflicts in the resolution of ' , resolution resolvedProjectVersion name
]

{ #category : #accessing }
CGOProjectHasConflictsError >> resolution: aCGOResolvedProject [ 
	resolution := aCGOResolvedProject
]
