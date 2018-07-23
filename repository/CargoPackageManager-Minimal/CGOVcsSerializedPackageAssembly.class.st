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
	"avoid nil values when a collection is expected"
	parts := self toArray: parts.

	^ PBAssembly new 
		initializeFromVcsSerializedPackage: self
]

{ #category : #initialization }
CGOVcsSerializedPackageAssembly >> initializePartsWith: aCGOOngoingPackageAssembly [
	parts := self serializedDependenciesOf: aCGOOngoingPackageAssembly parts
]

{ #category : #initialization }
CGOVcsSerializedPackageAssembly >> initializeWithOngoing: aCGOOngoingPackageAssembly [
	super initializeWithOngoing: aCGOOngoingPackageAssembly.
	self initializePartsWith: aCGOOngoingPackageAssembly.
]

{ #category : #accessing }
CGOVcsSerializedPackageAssembly >> parts [
	^ parts
]
