"
Specialization of the STON wrtier to avoid serialization of empty collections.
"
Class {
	#name : #CGOPackageVersionWriterV1,
	#superclass : #STONWriter,
	#category : #'CargoPackageManager-Minimal-Model-Serialization'
}

{ #category : #deserialization }
CGOPackageVersionWriterV1 class >> deserializeProject: aDictionary version: aString [ 
	^ self deserializeV1Project: aDictionary
]

{ #category : #deserialization }
CGOPackageVersionWriterV1 class >> deserializeV1Project: aDictionary [ 
	^ (CGOVcsSerializedProject fromDictionary: aDictionary) asOngoingProject
]

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
CGOPackageVersionWriterV1 class >> putDictionary: aDictionary onStreamPretty: aWriteStream [
	(self new on: aWriteStream)
		prettyPrint: false;
		nextPut: {#version -> '1.0'} asDictionary;
		prettyPrint: true;
		newLine;
		writeMap: aDictionary
]

{ #category : #convenience }
CGOPackageVersionWriterV1 class >> toStringPretty: anObject [
	^ String streamContents: [ :stream | 
		anObject isDictionary
			ifTrue: [ self putDictionary: anObject onStreamPretty: stream ]
			ifFalse: [ self put: anObject onStreamPretty: stream ]
		 ]
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
