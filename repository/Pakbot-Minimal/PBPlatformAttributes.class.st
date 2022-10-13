"
I represent the attributes of the current platform that can be used for conditional loading.
I have a default instance initialized at image startup coming with predefined values like:
- the OS family, name and version
- the Smalltalk family and  version
"
Class {
	#name : #PBPlatformAttributes,
	#superclass : #Object,
	#instVars : [
		'attributes'
	],
	#category : #'Pakbot-Minimal-Dependencies'
}

{ #category : #accessing }
PBPlatformAttributes class >> OSKey [
	^ 'OperatingSystem'
]

{ #category : #accessing }
PBPlatformAttributes class >> SmalltalkKey [
	^ 'Smalltalk'
]

{ #category : #accessing }
PBPlatformAttributes class >> macOSKey [
	^ self OSKey , self separator , 'mac OS'
]

{ #category : #accessing }
PBPlatformAttributes class >> separator [
	^ '::'
]

{ #category : #accessing }
PBPlatformAttributes class >> unixOSKey [
	^ self OSKey , self separator , 'Unix'
]

{ #category : #accessing }
PBPlatformAttributes class >> windowsOSKey [
	^ self OSKey , self separator , 'Windows'
]

{ #category : #initialization }
PBPlatformAttributes >> computeOperatingSystemValue [
	| osPlatform |
	osPlatform := OSPlatform current.
	^ String streamContents: [ :stream |
		stream 
			<< self class OSKey
			<< self class separator
			<< osPlatform family
			<< self class separator
			<< osPlatform name
			<< self class separator
			<< osPlatform version ]
]

{ #category : #initialization }
PBPlatformAttributes >> computeSmalltalkValue [
	^ String streamContents: [ :stream |
		stream 
			<< self class SmalltalkKey
			<< self class separator
			<< 'Pharo'
			<< self class separator
			<< SystemVersion current dottedMajorMinor ]
]

{ #category : #initialization }
PBPlatformAttributes >> initialize [ 
	attributes := Dictionary 
		with: self class OSKey -> self computeOperatingSystemValue
		with: self class SmalltalkKey -> self computeSmalltalkValue.
]

{ #category : #accessing }
PBPlatformAttributes >> operatingSystem [
	^ attributes at: self class OSKey
]

{ #category : #testing }
PBPlatformAttributes >> satisfies: aPBPlatformAttributeRequirement [ 

	^ attributes 
		at: aPBPlatformAttributeRequirement firstKey
		ifPresent: [ :value | value asLowercase beginsWith: aPBPlatformAttributeRequirement asLowercaseString  ]
		ifAbsent: [ false "not a predefined attribute" ].
	

]

{ #category : #accessing }
PBPlatformAttributes >> smalltalk [
	^ attributes at: self class SmalltalkKey 
]
