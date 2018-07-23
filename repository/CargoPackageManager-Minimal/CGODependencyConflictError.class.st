"
Error raised when a dependency cannot be resolved because of conflicting requirements.
ex: 
	example requires foo, bar
	foo requires PackageA 1.0
	bar requires PackageA 2.0
	=> conflict for PackageA
"
Class {
	#name : #CGODependencyConflictError,
	#superclass : #PBError,
	#instVars : [
		'policy1',
		'policy2'
	],
	#category : #'CargoPackageManager-Minimal-Model'
}

{ #category : #accessing }
CGODependencyConflictError >> policy1 [
	^ policy1
]

{ #category : #accessing }
CGODependencyConflictError >> policy1: anObject [
	policy1 := anObject
]

{ #category : #accessing }
CGODependencyConflictError >> policy2 [
	^ policy2
]

{ #category : #accessing }
CGODependencyConflictError >> policy2: anObject [
	policy2 := anObject
]
