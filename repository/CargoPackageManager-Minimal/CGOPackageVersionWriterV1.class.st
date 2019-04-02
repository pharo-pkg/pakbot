"
Specialization of the STON wrtier to avoid serialization of empty collections.
"
Class {
	#name : #CGOPackageVersionWriterV1,
	#superclass : #STONWriter,
	#category : #'CargoPackageManager-Minimal-Model-Serialization'
}

{ #category : #deserialization }
CGOPackageVersionWriterV1 class >> deserializeProject: aDictionary version: formatVersionString [ 
	"formatVersionString is the encoding format version.
	For now, there is only one format: v1"
	^ self deserializeV1ProjectWith: aDictionary
]

{ #category : #deserialization }
CGOPackageVersionWriterV1 class >> deserializeV1ProjectFromVcsWith: aDictionary [ 
	^ (PBVcsSerializedProject fromDictionary: aDictionary) asOngoingProject
]

{ #category : #deserialization }
CGOPackageVersionWriterV1 class >> deserializeV1ProjectWith: aDictionary [ 
	^ (PBSerializedProject fromDictionary: aDictionary) asProject
]

{ #category : #deserialization }
CGOPackageVersionWriterV1 class >> deserializeVcsProject: aDictionary version: formatVersionString [ 
	"formatVersionString is the encoding format version.
	For now, there is only one format: v1"
	^ self deserializeV1ProjectFromVcsWith: aDictionary
]

{ #category : #private }
CGOPackageVersionWriterV1 class >> newConfiguredWriterOn: aWriteStream [
	^ (self new on: aWriteStream)
		newLine: String crlf;
		prettyPrint: false;
		nextPut: {#version -> '1.0'} asDictionary;
		prettyPrint: true;
		newLine;
		yourself
]

{ #category : #convenience }
CGOPackageVersionWriterV1 class >> put: anObject onStreamPretty: aWriteStream [
	(self newConfiguredWriterOn: aWriteStream)
		nextPut: anObject
]

{ #category : #convenience }
CGOPackageVersionWriterV1 class >> putDictionary: aDictionary onStreamPretty: aWriteStream [
	(self newConfiguredWriterOn: aWriteStream)
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
