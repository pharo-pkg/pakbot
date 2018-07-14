"
I represent a Package version ready to be serialized.
I map some instance variables of PackageVersion to an easily serialized form (e.g. String, Array).
Do not use me directly but use one of my subclasses.
"
Class {
	#name : #CGOSerializedPackageVersion,
	#superclass : #CGOSerializedArtefact,
	#instVars : [
		'package',
		'timestamp'
	],
	#category : 'CargoPackageManager-Minimal-Model-Serialization'
}

{ #category : #mapping }
CGOSerializedPackageVersion >> dependencyConstraintsMapping: aDependency [
	^ (aDependency constraints collect: #asString)
			ifEmpty: [ #() ]
]

{ #category : #deserialization }
CGOSerializedPackageVersion >> deserialize: instVarName in: aPackageVersion [
	| deps |
	deps := self instVarNamed: instVarName.
	aPackageVersion 
		instVarNamed: instVarName
		put: (deps 
			ifNil: [ #() ]
			ifNotNil: [ deps collect:
				[ :association | CGOPackageDependency newFrom: association ] ])
]

{ #category : #deserialization }
CGOSerializedPackageVersion >> flushIn: aPackageVersion [
	"Flush information in this SerializedPackageVersion into the provided PackageVersion.
	All instance variables will be set with values from the SerializedPackageVersion"
	(package isNil or: [ version isNil ])
		ifTrue: [ self error: 'Cannot deserialize a PackageVersion with no package or version defined!' ].	
	aPackageVersion 
		instVarNamed: 'package' put: (CGOPackageProvider default packageNamed: package);
		instVarNamed: 'version' put: (SemanticVersion fromString: version);
		instVarNamed: 'description' put: description;
		instVarNamed: 'timestamp' put: timestamp;
		yourself.

]

{ #category : #initialization }
CGOSerializedPackageVersion >> initializeWith: aPackageVersion [
	package := aPackageVersion packageName.
	version := aPackageVersion version asString.
	description := aPackageVersion description.
	timestamp := aPackageVersion timestamp.
]
