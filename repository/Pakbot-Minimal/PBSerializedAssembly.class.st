"
I represent a Pakbot package assembly ready to be serialized.
"
Class {
	#name : #PBSerializedAssembly,
	#superclass : #PBSerializedArtefact,
	#instVars : [
		'parts'
	],
	#category : #'Pakbot-Minimal-Serialization'
}

{ #category : #converting }
PBSerializedAssembly >> asOngoingPackage [
	| assembly |
	dict 
		at: #name
		ifAbsent: [ PBError new 
						signal: 'Cannot deserialize an Assembly with no name defined!' ].
					
	assembly := PBAssembly named: (dict at: #name).
	dict at: #description ifPresent: [ :description | assembly description: description ].
	dict at: #packages ifPresent: [ :packages | 
		assembly packages: packages asOrderedCollection ].
	^ assembly

]

{ #category : #initialization }
PBSerializedAssembly >> initializePartsWith: aPBAssembly [
	parts := self serializedDependenciesOf: aPBAssembly parts
]

{ #category : #initialization }
PBSerializedAssembly >> initializeWithPackage: aPBAssembly [
	super initializeWithPackage: aPBAssembly.
	self 
		addPropertyNamed: #packages
		ifNotEmptyOrNil: (aPBAssembly packages collect: #name).
]

{ #category : #accessing }
PBSerializedAssembly >> parts [
	^ parts
]
