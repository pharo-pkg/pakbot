"
I represent a requirement on a specific platform.
I'm used to load packages / projects conditionaly, depending on the target platform.
ex: 
- load only on Windows
- load only on Pharo > 7.0
"
Class {
	#name : #PBPlatformAttributeRequirement,
	#superclass : #Object,
	#instVars : [
		'segments'
	],
	#category : #'Pakbot-Minimal-Dependencies'
}

{ #category : #'instance creation' }
PBPlatformAttributeRequirement class >> attributeSegments: aListOfNames [
	^ self new
		segments: aListOfNames;
		yourself
]

{ #category : #'instance creation' }
PBPlatformAttributeRequirement class >> fromString: aString [

	^ self attributeSegments: (PBPlatformAttributes separator split: aString)
]

{ #category : #'instance creation' }
PBPlatformAttributeRequirement class >> osFamily: aName [
	
	^ self attributeSegments: { PBPlatformAttributes OSKey . aName }
]

{ #category : #accessing }
PBPlatformAttributeRequirement >> asLowercaseString [
	^ (PBPlatformAttributes separator join: segments) asLowercase
]

{ #category : #accessing }
PBPlatformAttributeRequirement >> firstKey [
	^ segments first
]

{ #category : #initialization }
PBPlatformAttributeRequirement >> segments: aListOfNames [
	segments := aListOfNames asArray
]
