"
I represent a Cargo package ready to be serialized.
I factorize some fields declaration and some utilty methods.

Do not use me directly but use one of my subclasses!
"
Class {
	#name : #CGOVcsSerializedPackage,
	#superclass : #Object,
	#instVars : [
		'name',
		'description'
	],
	#category : #'CargoPackageManager-Minimal-Model-Serialization'
}

{ #category : #serialization }
CGOVcsSerializedPackage >> dependencyConstraintsMapping: aDependency [
	^ (aDependency constraints collect: #asString)
			ifEmpty: [ #() ]
]

{ #category : #accessing }
CGOVcsSerializedPackage >> description [
	^ description
]

{ #category : #utility }
CGOVcsSerializedPackage >> dictionaryOrNilIfEmpty: aDictionary [
	aDictionary ifNil: [ ^ nil ].
	^ aDictionary ifEmpty: [ nil ]
]

{ #category : #initialization }
CGOVcsSerializedPackage >> initializeWithOngoing: aCGOOngoingPackageUnit [
	name := aCGOOngoingPackageUnit packageName.
	description := aCGOOngoingPackageUnit description.
]

{ #category : #accessing }
CGOVcsSerializedPackage >> name [
	^ name
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
