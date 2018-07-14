"
I represent a Package unit ready to be serialized.
I map some instance variables of PackageVersion to an easily serialized form (e.g. String, Array)
"
Class {
	#name : #CGOSerializedPackageUnit,
	#superclass : #CGOSerializedPackageVersion,
	#instVars : [
		'src',
		'dependencies',
		'platformRequirements',
		'provisions'
	],
	#category : 'CargoPackageManager-Minimal-Model-Serialization'
}

{ #category : #'instance creation' }
CGOSerializedPackageUnit class >> from: aPackageUnit [
	^ self basicNew
		initializeWith: aPackageUnit;
		yourself
]

{ #category : #ston }
CGOSerializedPackageUnit class >> stonName [
	^ #CGOPublishedPackageUnit
]

{ #category : #deserialization }
CGOSerializedPackageUnit >> deserializeDependenciesIn: aPackageVersion [
	self 
		deserialize: 'dependencies'
		in: aPackageVersion
]

{ #category : #deserialization }
CGOSerializedPackageUnit >> flushIn: aPackageUnit [
	super flushIn: aPackageUnit.
	aPackageUnit 
		instVarNamed: 'src' put: src;
		instVarNamed: 'platformRequirements' put: (self toArray: platformRequirements);
		instVarNamed: 'provisions' put: (self toArray: (CGOPackageUnit provisionsFromListOfProvisionStrings: provisions)).
	self deserializeDependenciesIn: aPackageUnit
]

{ #category : #initialization }
CGOSerializedPackageUnit >> initializeDependenciesWith: aPackageUnit [
	dependencies := self toArray:
			(aPackageUnit dependencies collect: 
			[ :dependency | 
			Association 
				key: dependency targetedPackage
				value: (self dependencyConstraintsMapping: dependency) ])
]

{ #category : #initialization }
CGOSerializedPackageUnit >> initializeWith: aPackageUnit [
	super initializeWith: aPackageUnit.
	src := aPackageUnit sourcePackageVersion.
	self initializeDependenciesWith: aPackageUnit.
	platformRequirements := self toArrayOrNilIfEmpty: aPackageUnit platformRequirements.
	provisions := self toArrayOrNilIfEmpty: aPackageUnit provisions
]
