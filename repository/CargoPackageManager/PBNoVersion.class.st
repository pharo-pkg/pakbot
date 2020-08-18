"
I represent a semantic version that has not been set.
"
Class {
	#name : #PBNoVersion,
	#superclass : #Object,
	#category : #'CargoPackageManager-Model'
}

{ #category : #printing }
PBNoVersion >> printOn: aStream [
	aStream nextPutAll: 'no version set'
]
