"
I represent a Cargo package unit ready to be serialized on a Version Control System (e.g. git).
I map some instance variables  to an easily serialized form and skip some others variables for the serialization.
"
Class {
	#name : #CGOVcsSerializedPackageUnit,
	#superclass : #CGOVcsSerializedPackage,
	#instVars : [
		'dependencies'
	],
	#category : #'CargoPackageManager-Minimal-Model-Serialization'
}

{ #category : #'instance creation' }
CGOVcsSerializedPackageUnit class >> from: aCGOOngoingPackageUnit [
	^ self basicNew
		initializeWithOngoing: aCGOOngoingPackageUnit;
		yourself
]

{ #category : #ston }
CGOVcsSerializedPackageUnit class >> stonName [
	^ #OngoingPackageUnit
]

{ #category : #converting }
CGOVcsSerializedPackageUnit >> asOngoingPackage [
	| unit |
	dict 
		at: #name
		ifAbsent: [ CGOPackageManagerError new 
						signal: 'Cannot deserialize a Project with no name defined!' ].
					
	unit := CGOOngoingPackageUnit named: (dict at: #name).
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
CGOVcsSerializedPackageUnit >> dependencies [
	^ dependencies collect: [ :each |
		each isSymbol 	
			ifTrue: [ Association key: each value: #() ]
			ifFalse: [ each ] ]
]

{ #category : #initialization }
CGOVcsSerializedPackageUnit >> initializeWithOngoing: aCGOOngoingPackageUnit [
	super initializeWithOngoing: aCGOOngoingPackageUnit.
	self addPropertyNamed: #dependencies ifNotEmptyOrNil: (self serializedDependenciesOf: aCGOOngoingPackageUnit dependencies).
	self addPropertyNamed: #platformRequirements ifNotEmptyOrNil: aCGOOngoingPackageUnit platformRequirements.
	self addPropertyNamed: #provisions ifNotEmptyOrNil: aCGOOngoingPackageUnit provisions.
]
