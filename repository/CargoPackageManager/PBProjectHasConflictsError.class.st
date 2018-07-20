"
This error is signaled when a project with conflicts is tried to be loaded.
"
Class {
	#name : #PBProjectHasConflictsError,
	#superclass : #PBError,
	#instVars : [
		'resolution'
	],
	#category : #'CargoPackageManager-Solver'
}

{ #category : #signalling }
PBProjectHasConflictsError class >> signalOnResolution: aResolution [

	^ self new
		resolution: aResolution;
		signal
	
]

{ #category : #visiting }
PBProjectHasConflictsError >> acceptVisitor: aVisitor [

	^ aVisitor visitProjectWithConflictsError: self
]

{ #category : #private }
PBProjectHasConflictsError >> isResumable [

	^ true
]

{ #category : #accessing }
PBProjectHasConflictsError >> messageText [
	^ 'There are conflicts in the resolution of ' , resolution resolvedProjectVersion name
]

{ #category : #accessing }
PBProjectHasConflictsError >> resolution: aCGOResolvedProject [ 
	resolution := aCGOResolvedProject
]
