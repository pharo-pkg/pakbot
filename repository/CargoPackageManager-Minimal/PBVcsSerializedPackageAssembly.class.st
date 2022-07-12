"
I represent a Cargo package assembly ready to be serialized on a Version Control System (e.g. git).
"
Class {
	#name : #PBVcsSerializedPackageAssembly,
	#superclass : #PBSerializedArtefact,
	#instVars : [
		'parts'
	],
	#category : #'CargoPackageManager-Minimal-Model-Serialization'
}

{ #category : #converting }
PBVcsSerializedPackageAssembly >> asOngoingPackage [
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
PBVcsSerializedPackageAssembly >> initializePartsWith: aPBAssembly [
	parts := self serializedDependenciesOf: aPBAssembly parts
]

{ #category : #initialization }
PBVcsSerializedPackageAssembly >> initializeWithPackage: aPBAssembly [
	super initializeWithPackage: aPBAssembly.
	self 
		addPropertyNamed: #packages
		ifNotEmptyOrNil: (aPBAssembly packages collect: #name).
]

{ #category : #accessing }
PBVcsSerializedPackageAssembly >> parts [
	^ parts
]
