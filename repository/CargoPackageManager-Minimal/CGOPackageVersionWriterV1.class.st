"
Specialization of the STON wrtier to avoid serialization of empty collections.
"
Class {
	#name : #CGOPackageVersionWriterV1,
	#superclass : #STONWriter,
	#category : #'CargoPackageManager-Minimal-Model-Serialization'
}

{ #category : #convenience }
CGOPackageVersionWriterV1 class >> put: anObject onStreamPretty: aWriteStream [
	(self new on: aWriteStream)
		prettyPrint: false;
		nextPut: {#version -> '1.0'} asDictionary;
		prettyPrint: true;
		newLine;
		nextPut: anObject
]

{ #category : #convenience }
CGOPackageVersionWriterV1 class >> toStringPretty: object [
	^ String streamContents: [ :stream |
		self put: object onStreamPretty: stream ]
]

{ #category : #initialization }
CGOPackageVersionWriterV1 >> initialize [
	super initialize.
	self referencePolicy: #ignore.
	self prettyPrint: true
]

{ #category : #convenience }
CGOPackageVersionWriterV1 >> newLine [
	writeStream nextPutAll: newLine.
]
