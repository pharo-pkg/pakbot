"
I represent a Pakbot package unit ready to be serialized.
I map some instance variables  to an easily serialized form and skip some others variables for the serialization.
"
Class {
	#name : #PBSerializedPackage,
	#superclass : #PBSerializedArtefact,
	#instVars : [
		'dependencies'
	],
	#category : #'Pakbot-Minimal-Serialization'
}

{ #category : #converting }
PBSerializedPackage >> asOngoingPackage [
	| unit |
	dict 
		at: #name
		ifAbsent: [ PBError new 
						signal: 'Cannot deserialize a Package with no name defined!' ].
					
	unit := PBPackage named: (dict at: #name).
	dict at: #description ifPresent: [ :description | unit description: description ].
	dict at: #dependencies ifPresent: [ :deps | 
		unit dependencies: (self deserializedDependencies: deps) asOrderedCollection ].
	dict at: #provisions ifPresent: [ :provisions | 
		unit provisions: provisions asOrderedCollection ].
	dict at: #platformRequirements ifPresent: [ :platformRequirements | 
		unit provisions: platformRequirements asOrderedCollection ].
	^ unit
]

{ #category : #accessing }
PBSerializedPackage >> dependencies [
	^ dependencies collect: [ :each |
		each isSymbol 	
			ifTrue: [ Association key: each value: #() ]
			ifFalse: [ each ] ]
]

{ #category : #initialization }
PBSerializedPackage >> initializeWithPackage: aPBPackageUnit [
	super initializeWithPackage: aPBPackageUnit.
	self addPropertyNamed: #dependencies ifNotEmptyOrNil: (self serializedDependenciesOf: aPBPackageUnit dependencies).
	self addPropertyNamed: #platformRequirements ifNotEmptyOrNil: aPBPackageUnit platformRequirements.
	self addPropertyNamed: #provisions ifNotEmptyOrNil: aPBPackageUnit provisions.
]
