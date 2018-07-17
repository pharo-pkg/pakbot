"
I represent a Cargo package ready to be serialized.
I factorize some fields declaration and some utilty methods.

Do not use me directly but use one of my subclasses!
"
Class {
	#name : #CGOVcsSerializedPackage,
	#superclass : #Object,
	#instVars : [
		'dict'
	],
	#category : #'CargoPackageManager-Minimal-Model-Serialization'
}

{ #category : #'instance creation' }
CGOVcsSerializedPackage class >> fromDictionary: aDictionary [ 
	^ self basicNew 
		initializeWithDictionary: aDictionary;
		yourself.
]

{ #category : #utility }
CGOVcsSerializedPackage >> addPropertyNamed: aString ifNotEmptyOrNil: aCollection [ 
	aCollection ifNil: [ ^ self ]. "NOOP"
	^ aCollection
		ifNotEmpty: [ dict at: aString  put: aCollection asArray ]
]

{ #category : #serialization }
CGOVcsSerializedPackage >> asString [
	^ CGOPackageVersionWriterV1 toStringPretty: dict
]

{ #category : #serialization }
CGOVcsSerializedPackage >> dependencyConstraintsMapping: aDependency [
	^ (aDependency constraints collect: #asString)
			ifEmpty: [ #() ]
]

{ #category : #deserialization }
CGOVcsSerializedPackage >> deserializedDependencies: aListOfSerializedDependencies [
	^ aListOfSerializedDependencies 
		ifNil: [ OrderedCollection empty ]
		ifNotNil: [ aListOfSerializedDependencies collect:
				[ :associationOrString | | association |
					association := associationOrString isString 
						ifTrue: [ associationOrString -> #() ]
						ifFalse: [ associationOrString ].
					CGOPackageDependency newFrom: association ] ]
]

{ #category : #utility }
CGOVcsSerializedPackage >> dictionaryOrNilIfEmpty: aDictionary [
	aDictionary ifNil: [ ^ nil ].
	^ aDictionary ifEmpty: [ nil ]
]

{ #category : #initialization }
CGOVcsSerializedPackage >> initializeWithDictionary: aDictionary [ 
	dict := aDictionary
]

{ #category : #initialization }
CGOVcsSerializedPackage >> initializeWithOngoing: aCGOOngoingPackageUnit [
	dict := OrderedDictionary new.
	dict at: #name put: aCGOOngoingPackageUnit packageName.
	dict at: #description put: aCGOOngoingPackageUnit description.
]

{ #category : #serialization }
CGOVcsSerializedPackage >> serializedDependenciesOf: aPackageDependencyList [
	^ self toArray:
		(aPackageDependencyList
			collect: [ :dependency |	| constraints |
				constraints := self dependencyConstraintsMapping: dependency.
				constraints
					ifEmpty: [ dependency dependencyName ]
					ifNotEmpty: [ Association key: dependency dependencyName value: constraints ] ])
]

{ #category : #serialization }
CGOVcsSerializedPackage >> stonOn: stonWriter [
	stonWriter writeMap: dict
]

{ #category : #utility }
CGOVcsSerializedPackage >> toArray: aCollection [
	^ aCollection 
		ifNil: [ #() ]
		ifNotNil: [ aCollection asArray ]
]

{ #category : #utility }
CGOVcsSerializedPackage >> toArrayOrNilIfEmpty: aCollection [
	aCollection ifNil: [ ^ nil ].
	^ aCollection
		ifEmpty: [ nil ]
		ifNotEmpty: [aCollection asArray ]
]

{ #category : #utility }
CGOVcsSerializedPackage >> toDictionary: aDictionaryOrNil [
	^ aDictionaryOrNil ifNil: [ ^ Dictionary new ]
]
