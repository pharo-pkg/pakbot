"
Specialization of the STON wrtier to avoid serialization of empty collections.
"
Class {
	#name : #CGOPackageVersionWriter,
	#superclass : #STONWriter,
	#category : 'CargoPackageManager-Minimal-Model-Serialization'
}

{ #category : #convenience }
CGOPackageVersionWriter class >> put: anObject onStreamPretty: aWriteStream [
	(self new on: aWriteStream)
		prettyPrint: false;
		nextPut: {#version -> '1.0'} asDictionary;
		prettyPrint: true;
		newLine;
		nextPut: anObject
]

{ #category : #convenience }
CGOPackageVersionWriter class >> toStringPretty: object [
	^ String streamContents: [ :stream |
		self put: object onStreamPretty: stream ]
]

{ #category : #initialization }
CGOPackageVersionWriter >> initialize [
	super initialize.
	self referencePolicy: #ignore.
	self prettyPrint: true
]

{ #category : #convenience }
CGOPackageVersionWriter >> newLine [
	writeStream nextPutAll: newLine.
]
