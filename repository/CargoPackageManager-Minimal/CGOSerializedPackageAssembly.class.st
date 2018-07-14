"
I represent a Package assembly ready to be serialized.
I'm there to get a custom and short STON serialization.
"
Class {
	#name : #CGOSerializedPackageAssembly,
	#superclass : #CGOSerializedPackageVersion,
	#instVars : [
		'parts'
	],
	#category : 'CargoPackageManager-Minimal-Model-Serialization'
}

{ #category : #'instance creation' }
CGOSerializedPackageAssembly class >> from: aPackageAssembly [
	^ self basicNew
		initializeWith: aPackageAssembly;
		yourself
]

{ #category : #ston }
CGOSerializedPackageAssembly class >> stonName [
	^ #CGOPublishedPackageAssembly
]

{ #category : #deserialization }
CGOSerializedPackageAssembly >> deserializeParts [
	^ parts collect: #asPackageVersionReference 
]

{ #category : #deserialization }
CGOSerializedPackageAssembly >> deserializePartsIn: aPackageAssembly [
	self 
		deserialize: 'parts'
		in: aPackageAssembly
]

{ #category : #deserialization }
CGOSerializedPackageAssembly >> flushIn: aPackageAssembly [
	super flushIn: aPackageAssembly.
	self deserializePartsIn: aPackageAssembly
]

{ #category : #initialization }
CGOSerializedPackageAssembly >> initializePartsWith: aPackageAssembly [
	parts := self
		toArrayOrNilIfEmpty:
			(aPackageAssembly parts collect: 
			[ :part | 
			Association 
				key: part targetedPackage
				value: (self dependencyConstraintsMapping: part) ])
]

{ #category : #initialization }
CGOSerializedPackageAssembly >> initializeWith: aPackageAssembly [
	super initializeWith: aPackageAssembly.
	self initializePartsWith: aPackageAssembly
]
