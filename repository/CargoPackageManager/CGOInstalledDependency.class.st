"
I represent a conflicting project that is installed in the image.
I am polimorphic with CGOResolvedDependency.  I am used by the resolution of conflicts.
See PBConflict
"
Class {
	#name : #CGOInstalledDependency,
	#superclass : #Object,
	#instVars : [
		'resolved'
	],
	#category : #'CargoPackageManager-Solver'
}

{ #category : #'instance creation' }
CGOInstalledDependency class >> onResolved: aProject [
	^ self new
		resolved: aProject;
		yourself
]

{ #category : #accessing }
CGOInstalledDependency >> dependency [
	^ resolved resolvedProjectVersion 
]

{ #category : #testing }
CGOInstalledDependency >> isInstalledDependency [

	^ true
]

{ #category : #printing }
CGOInstalledDependency >> printOn: aStream [

	aStream
		nextPutAll: self class name;
		nextPutAll: '(';
		print: resolved;
		nextPutAll: ')'
]

{ #category : #accessing }
CGOInstalledDependency >> projectName [
	^ resolved name
]

{ #category : #accessing }
CGOInstalledDependency >> resolution [
	^ resolved
]

{ #category : #resolving }
CGOInstalledDependency >> resolveWith: aResolved [ 
	
	"Nothing to do"
]

{ #category : #accessing }
CGOInstalledDependency >> resolved: aProject [ 
	resolved := aProject
]
