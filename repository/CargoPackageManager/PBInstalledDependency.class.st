"
I represent a conflicting project that is installed in the image.
I am polimorphic with CGOResolvedDependency.  I am used by the resolution of conflicts.
See PBConflict
"
Class {
	#name : #PBInstalledDependency,
	#superclass : #Object,
	#instVars : [
		'resolved'
	],
	#category : #'CargoPackageManager-Solver'
}

{ #category : #'instance creation' }
PBInstalledDependency class >> onResolved: aProject [
	^ self new
		resolved: aProject;
		yourself
]

{ #category : #accessing }
PBInstalledDependency >> dependency [
	^ resolved resolvedProjectVersion 
]

{ #category : #testing }
PBInstalledDependency >> isInstalledDependency [

	^ true
]

{ #category : #accessing }
PBInstalledDependency >> originalResolution [
	^ self resolution
]

{ #category : #printing }
PBInstalledDependency >> printOn: aStream [

	aStream
		nextPutAll: self class name;
		nextPutAll: '(';
		print: resolved;
		nextPutAll: ')'
]

{ #category : #accessing }
PBInstalledDependency >> projectName [
	^ resolved name
]

{ #category : #accessing }
PBInstalledDependency >> resolution [
	^ resolved
]

{ #category : #resolving }
PBInstalledDependency >> resolveWith: aResolved [ 
	
	"Nothing to do"
]

{ #category : #accessing }
PBInstalledDependency >> resolved: aProject [ 
	resolved := aProject
]
