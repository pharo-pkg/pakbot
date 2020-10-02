"
I represent a Pakbot artefact ready to be serialized.
I factorize some fields declaration and some utility methods.

Do not use me directly but use one of my subclasses!
"
Class {
	#name : #PBSerializedArtefact,
	#superclass : #Object,
	#instVars : [
		'dict'
	],
	#category : #'CargoPackageManager-Minimal-Model-Serialization'
}

{ #category : #'instance creation' }
PBSerializedArtefact class >> from: aPackage [
	^ self new
		initializeWithPackage: aPackage;
		yourself
]

{ #category : #'instance creation' }
PBSerializedArtefact class >> fromDictionary: aDictionary [ 
	^ self basicNew 
		initializeWithDictionary: aDictionary;
		yourself.
]

{ #category : #utility }
PBSerializedArtefact >> addPropertyNamed: aString ifNotEmptyOrNil: aCollection [ 
	aCollection ifNil: [ ^ self ]. "NOOP"
	^ aCollection
		ifNotEmpty: [ dict at: aString  put: aCollection asArray ]
]

{ #category : #serialization }
PBSerializedArtefact >> asString [
	^ CGOPackageVersionWriterV1 toStringPretty: dict
]

{ #category : #serialization }
PBSerializedArtefact >> dependencyConstraintsMapping: aDependency [
	^ (aDependency constraints collect: #asString)
			ifEmpty: [ #() ]
]

{ #category : #deserialization }
PBSerializedArtefact >> deserializedDependencies: aListOfSerializedDependencies [
	^ aListOfSerializedDependencies 
		ifNil: [ OrderedCollection empty ]
		ifNotNil: [ aListOfSerializedDependencies collect:
				[ :associationOrString | | association |
					association := associationOrString isString 
						ifTrue: [ associationOrString -> #() ]
						ifFalse: [ associationOrString ].
					PBPackageDependency newFrom: association ] ]
]

{ #category : #initialization }
PBSerializedArtefact >> initializeWithDictionary: aDictionary [ 
	dict := aDictionary
]

{ #category : #initialization }
PBSerializedArtefact >> initializeWithPackage: aPBPackage [
	dict := OrderedDictionary new.
	dict at: #name put: aPBPackage name.
	aPBPackage description 
		ifNotNil: [ dict at: #description put: aPBPackage description ].
]

{ #category : #accessing }
PBSerializedArtefact >> propertyNamed: aName [
	^ dict at: aName
]

{ #category : #serialization }
PBSerializedArtefact >> serializedDependenciesOf: aPackageDependencyList [
	^ self toArray:
		(aPackageDependencyList
			collect: [ :dependency |	| constraints |
				constraints := self dependencyConstraintsMapping: dependency.
				constraints
					ifEmpty: [ dependency name ]
					ifNotEmpty: [ Association key: dependency name value: constraints ] ])
]

{ #category : #utility }
PBSerializedArtefact >> sort: packages andCollect: aSelector [
	^ (packages sorted: [ :a :b | a name < b name ])
			collect: aSelector 
]

{ #category : #serialization }
PBSerializedArtefact >> stonOn: stonWriter [
	"customize ston serialization to only serialize dictionary"
	stonWriter writeMap: dict
]

{ #category : #utility }
PBSerializedArtefact >> toArray: aCollection [
	^ aCollection 
		ifNil: [ #() ]
		ifNotNil: [ aCollection asArray ]
]

{ #category : #utility }
PBSerializedArtefact >> toArrayOrNilIfEmpty: aCollection [
	aCollection ifNil: [ ^ nil ].
	^ aCollection
		ifEmpty: [ nil ]
		ifNotEmpty: [aCollection asArray ]
]
