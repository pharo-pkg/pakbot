"
Error thrown when a dependency is not resolved to a specific package version at the call time.
"
Class {
	#name : #PBUnresolvedDependency,
	#superclass : #PBError,
	#instVars : [
		'candidates'
	],
	#category : #'CargoPackageManager-Solver'
}

{ #category : #signaling }
PBUnresolvedDependency class >> package: aPackageName [
	^ self new 
		package: aPackageName
]

{ #category : #signaling }
PBUnresolvedDependency class >> package: aPackageName candidates: aPackageVersionReferenceList [
	^ self new 
		package: aPackageName candidates: aPackageVersionReferenceList
]

{ #category : #accessing }
PBUnresolvedDependency >> candidates [
	^ candidates
]

{ #category : #signaling }
PBUnresolvedDependency >> package: aPackageName [
	^ self signal: 'Unresolved dependency: ' , aPackageName
]

{ #category : #signaling }
PBUnresolvedDependency >> package: aPackageName candidates: aPackageVersionReferenceList [
	candidates := aPackageVersionReferenceList.
	^ self signal: 'Unresolved dependency: ' , aPackageName , ' has ' , aPackageVersionReferenceList size asString , ' candidates!'
]
