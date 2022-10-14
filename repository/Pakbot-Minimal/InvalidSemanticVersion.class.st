"
When parsing a semantic version from a String, you will get:
- either a `SemanticVersion` instance if it is a valid semantic version,
- or an `InvalidSemanticVersion` instance if the parsing failed
"
Class {
	#name : #InvalidSemanticVersion,
	#superclass : #Object,
	#instVars : [
		'version'
	],
	#category : #'Pakbot-Minimal-Model'
}

{ #category : #'instance creation' }
InvalidSemanticVersion class >> fromString: aString [
	^ self new 
		version: aString;
		yourself
]

{ #category : #comparing }
InvalidSemanticVersion >> = anotherVersion [
	
	self == anotherVersion ifTrue: [ ^ true ].
	self species ~= anotherVersion species ifTrue: [ ^ false ].
	^ self version = anotherVersion version
]

{ #category : #converting }
InvalidSemanticVersion >> asSemanticVersion [
	^ self
]

{ #category : #comparing }
InvalidSemanticVersion >> hash [

	^ version hash
]

{ #category : #testing }
InvalidSemanticVersion >> isInvalid [
	^ true
]

{ #category : #printing }
InvalidSemanticVersion >> printOn: aStream [
	
	aStream nextPutAll: version asString
]

{ #category : #accessing }
InvalidSemanticVersion >> version [
	^ version
]

{ #category : #accessing }
InvalidSemanticVersion >> version: anObject [
	version := anObject
]
