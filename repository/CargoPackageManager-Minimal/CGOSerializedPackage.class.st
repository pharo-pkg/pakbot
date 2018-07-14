"
I represent a Cargo package ready to be serialized.
I factorize some fields declaration and some utilty methods.

Do not use me directly but use one of my subclasses!
"
Class {
	#name : #CGOSerializedPackage,
	#superclass : #Object,
	#instVars : [
		'name',
		'description'
	],
	#category : 'CargoPackageManager-Minimal-Model-Serialization'
}

{ #category : #serialization }
CGOSerializedPackage >> dependencyConstraintsMapping: aDependency [
	^ (aDependency constraints collect: #asString)
			ifEmpty: [ #() ]
]

{ #category : #accessing }
CGOSerializedPackage >> description [
	^ description
]

{ #category : #utility }
CGOSerializedPackage >> dictionaryOrNilIfEmpty: aDictionary [
	aDictionary ifNil: [ ^ nil ].
	^ aDictionary ifEmpty: [ nil ]
]

{ #category : #initialization }
CGOSerializedPackage >> initializeWithOngoing: aCGOOngoingPackageUnit [
	name := aCGOOngoingPackageUnit packageName.
	description := aCGOOngoingPackageUnit description.
]

{ #category : #accessing }
CGOSerializedPackage >> name [
	^ name
]

{ #category : #serialization }
CGOSerializedPackage >> serializedDependenciesOf: aPackageDependencyList [
	^ self toArray:
		(aPackageDependencyList
			collect: [ :dependency |	| constraints |
				constraints := self dependencyConstraintsMapping: dependency.
				constraints
					ifEmpty: [ dependency dependencyName ]
					ifNotEmpty: [ Association key: dependency dependencyName value: constraints ] ])
]

{ #category : #utility }
CGOSerializedPackage >> toArray: aCollection [
	^ aCollection 
		ifNil: [ #() ]
		ifNotNil: [ aCollection asArray ]
]

{ #category : #utility }
CGOSerializedPackage >> toArrayOrNilIfEmpty: aCollection [
	aCollection ifNil: [ ^ nil ].
	^ aCollection
		ifEmpty: [ nil ]
		ifNotEmpty: [aCollection asArray ]
]

{ #category : #utility }
CGOSerializedPackage >> toDictionary: aDictionaryOrNil [
	^ aDictionaryOrNil ifNil: [ ^ Dictionary new ]
]
