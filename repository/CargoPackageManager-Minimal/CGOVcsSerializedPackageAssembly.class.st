"
I represent a Cargo package assembly ready to be serialized on a Version Control System (e.g. git).
"
Class {
	#name : #CGOVcsSerializedPackageAssembly,
	#superclass : #CGOVcsSerializedPackage,
	#instVars : [
		'parts'
	],
	#category : #'CargoPackageManager-Minimal-Model-Serialization'
}

{ #category : #'instance creation' }
CGOVcsSerializedPackageAssembly class >> from: aCGOOngoingPackageAssembly [
	^ self basicNew
		initializeWithOngoing: aCGOOngoingPackageAssembly;
		yourself
]

{ #category : #converting }
CGOVcsSerializedPackageAssembly >> asOngoingPackage [
	| assembly |
	dict 
		at: #name
		ifAbsent: [ PBError new 
						signal: 'Cannot deserialize an Assembly with no name defined!' ].
					
	assembly := PBAssembly named: (dict at: #name).
	dict at: #description ifPresent: [ :description | assembly description: description ].
	dict at: #parts ifPresent: [ :packages | 
		assembly parts: packages asOrderedCollection ].
	^ assembly

]

{ #category : #initialization }
CGOVcsSerializedPackageAssembly >> initializePartsWith: aCGOOngoingPackageAssembly [
	parts := self serializedDependenciesOf: aCGOOngoingPackageAssembly parts
]

{ #category : #initialization }
CGOVcsSerializedPackageAssembly >> initializeWithOngoing: aCGOOngoingPackageAssembly [
	super initializeWithOngoing: aCGOOngoingPackageAssembly.
	self 
		addPropertyNamed: #parts
		ifNotEmptyOrNil: aCGOOngoingPackageAssembly parts.
]

{ #category : #accessing }
CGOVcsSerializedPackageAssembly >> parts [
	^ parts
]
