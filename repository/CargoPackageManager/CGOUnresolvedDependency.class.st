"
Error thrown when a dependency is not resolved to a specific package version at the call time.
"
Class {
	#name : #CGOUnresolvedDependency,
	#superclass : #CGOPackageManagerError,
	#instVars : [
		'candidates'
	],
	#category : 'CargoPackageManager-Solver'
}

{ #category : #signaling }
CGOUnresolvedDependency class >> package: aPackageName [
	^ self new 
		package: aPackageName
]

{ #category : #signaling }
CGOUnresolvedDependency class >> package: aPackageName candidates: aPackageVersionReferenceList [
	^ self new 
		package: aPackageName candidates: aPackageVersionReferenceList
]

{ #category : #accessing }
CGOUnresolvedDependency >> candidates [
	^ candidates
]

{ #category : #signaling }
CGOUnresolvedDependency >> package: aPackageName [
	^ self signal: 'Unresolved dependency: ' , aPackageName
]

{ #category : #signaling }
CGOUnresolvedDependency >> package: aPackageName candidates: aPackageVersionReferenceList [
	candidates := aPackageVersionReferenceList.
	^ self signal: 'Unresolved dependency: ' , aPackageName , ' has ' , aPackageVersionReferenceList size asString , ' candidates!'
]
