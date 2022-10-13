"
I represent a semantic version that has not been set.
"
Class {
	#name : #PBNoVersion,
	#superclass : #Object,
	#category : #'Pakbot-Minimal-Model'
}

{ #category : #comparing }
PBNoVersion >> = anObject [
	^ anObject class == self class
]

{ #category : #testing }
PBNoVersion >> isInvalid [
	^ true
]

{ #category : #printing }
PBNoVersion >> printOn: aStream [
	aStream nextPutAll: 'no version set'
]
