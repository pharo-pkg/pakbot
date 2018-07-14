"
I represent a Cargo artefact ready to be serialized.
I factorize some fields declaration and some utilty methods.

Do not use me directly but use one of my subclasses!
"
Class {
	#name : #CGOSerializedArtefact,
	#superclass : #Object,
	#instVars : [
		'description',
		'version'
	],
	#category : 'CargoPackageManager-Minimal-Model-Serialization'
}

{ #category : #utility }
CGOSerializedArtefact >> toArray: aCollection [
	^ aCollection 
		ifNil: [ #() ]
		ifNotNil: [ aCollection asArray ]
]

{ #category : #utility }
CGOSerializedArtefact >> toArrayOrNilIfEmpty: aCollection [
	aCollection ifNil: [ ^ nil ].
	^ aCollection
		ifEmpty: [ nil ]
		ifNotEmpty: [aCollection asArray ]
]
