"
I represent a specific version of a virtual package.
See CGOVirtualPackage for more information.

My main goal is to provide some metadata on a virtual package.
My description should describe the contract (i.e. the API) so that implementors and users of this virtual packages are aware of it.

example: Mongo@1.0
	* #open
	* #close
	* #query:
	* #queryOne:
"
Class {
	#name : #CGOVirtualPackageVersion,
	#superclass : #CGOPackageVersion,
	#category : 'CargoPackageManager-Minimal-Model'
}

{ #category : #example }
CGOVirtualPackageVersion class >> example [
	^ self newFrom:
	 	( Dictionary new
			add: #package -> #Mail;
			add: #version -> '1.0' asSemanticVersion;
			add: #description -> 'I respect the mail protocol V1.0. See link for more details.';
			add: #project -> CGOProject example;
			yourself ).
]

{ #category : #'instance creation' }
CGOVirtualPackageVersion class >> newFrom: aDictionary [
	^ self new
		initializeFrom: aDictionary;
		yourself
]

{ #category : #converting }
CGOVirtualPackageVersion >> asOngoingPackage [
	^ CGOOngoingVirtualPackage fromPackageVersion: self
]

{ #category : #converting }
CGOVirtualPackageVersion >> asSerializablePackageVersion [
	^ CGOSerializedVirtualPackageVersion from: self
]

{ #category : #ston }
CGOVirtualPackageVersion >> fromSton: stonReader [
	super fromSton: stonReader.
	package := CGOPackageProvider default virtualPackageNamed: package.
]

{ #category : #initialization }
CGOVirtualPackageVersion >> initializeFrom: aDictionary [
	super initializeFrom: aDictionary.
	package := self packageFrom: aDictionary.
]

{ #category : #testing }
CGOVirtualPackageVersion >> isVirtual [
	^ true
]

{ #category : #'initialization - private' }
CGOVirtualPackageVersion >> packageFrom: aDictionary [
	| aSymbol |
	aSymbol := self mandatoryKey: #package from: aDictionary.
	aSymbol isSymbol
		ifFalse: [ CGOPackageVersionInitializationError signal: 'The package value must be a Symbol' ].
	^ CGOPackageProvider default virtualPackageNamed: aSymbol
]

{ #category : #printing }
CGOVirtualPackageVersion >> printOn: aStream [
	aStream << self packageName << '@' << (self version asString) << ' (virtual)'
]

{ #category : #compatibility }
CGOVirtualPackageVersion >> provisions [
	^ #()
]
