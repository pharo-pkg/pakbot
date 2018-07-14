"
I represent a Cargo package unit ready to be serialized on a Version Control System (e.g. git).
I map some instance variables  to an easily serialized form and skip some others variables for the serialization.
"
Class {
	#name : #CGOVcsSerializedPackageUnit,
	#superclass : #CGOSerializedPackage,
	#instVars : [
		'dependencies',
		'provisions',
		'platformRequirements'
	],
	#category : 'CargoPackageManager-Minimal-Model-Serialization'
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
	"avoid nil values when a collection is expected"
	platformRequirements := self toArray: platformRequirements.
	provisions := self toArray: provisions.
	
	^ CGOOngoingPackageUnit new 	
		initializeFromVcsSerializedPackage: self
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
	dependencies := self serializedDependenciesOf: aCGOOngoingPackageUnit dependencies.
	platformRequirements := self toArrayOrNilIfEmpty: aCGOOngoingPackageUnit platformRequirements.
	provisions := self toArrayOrNilIfEmpty: aCGOOngoingPackageUnit provisions
]

{ #category : #accessing }
CGOVcsSerializedPackageUnit >> packageName [
	^ name
]

{ #category : #accessing }
CGOVcsSerializedPackageUnit >> platformRequirements [
	^ platformRequirements
]

{ #category : #accessing }
CGOVcsSerializedPackageUnit >> provisions [
	^ provisions
]
