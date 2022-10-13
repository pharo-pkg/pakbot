"
I  represent a conflicting project that is installed in the image.
I  am polymorphic with PBResolvedDependency. I  am used by the resolution of conflicts.
See PBConflict
"
Class {
	#name : #PBInstalledDependency,
	#superclass : #Object,
	#instVars : [
		'resolved'
	],
	#category : #'Pakbot-Core-Solver'
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

{ #category : #accessing }
PBInstalledDependency >> fullVersionString [

		^ self originalResolution fullVersionString , ', Installed'
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
PBInstalledDependency >> resolved: aResolvedProject [ 
	resolved := aResolvedProject.
	aResolvedProject beInstalledInImage.
]
