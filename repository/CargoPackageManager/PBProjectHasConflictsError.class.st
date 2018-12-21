"
This error is signaled when a project with conflicts is tried to be loaded or published.
"
Class {
	#name : #PBProjectHasConflictsError,
	#superclass : #PBError,
	#instVars : [
		'resolution'
	],
	#category : #'CargoPackageManager-Solver'
}

{ #category : #signaling }
PBProjectHasConflictsError class >> signalOnResolution: aResolution [

	^ self new
		resolution: aResolution;
		signal
]

{ #category : #visiting }
PBProjectHasConflictsError >> acceptVisitor: aVisitor [

	^ aVisitor visitProjectWithConflictsError: self
]

{ #category : #accessing }
PBProjectHasConflictsError >> conflicts [
	^ resolution conflicts
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
PBProjectHasConflictsError >> resolution [
	^ resolution
]

{ #category : #accessing }
PBProjectHasConflictsError >> resolution: aCGOResolvedProject [ 
	resolution := aCGOResolvedProject
]
