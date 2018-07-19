"
Local repository used to cache package descriptions fetched from remote repositories.
"
Class {
	#name : #CGOPackageVersionCache,
	#superclass : #Object,
	#instVars : [
		'packageRepositories',
		'packageName',
		'versionNumber'
	],
	#category : 'CargoPackageManager-Minimal-Model'
}

{ #category : #defaults }
CGOPackageVersionCache class >> packageDescriptionCache [
	^ self new packageDescriptionCache
]

{ #category : #decoding }
CGOPackageVersionCache >> decode: aFileReference [
	^ [ STON fromStream: aFileReference readStream ]
		on: Error
		do: [ nil ]
]

{ #category : #fetching }
CGOPackageVersionCache >> fetchDescription: aPackageVersionString [
	| fileRef |
	fileRef := self packageDescriptionCache / aPackageVersionString asLowercase.
	^ fileRef exists
		ifTrue: [ self decode: fileRef ]
		ifFalse: [ nil ]
]

{ #category : #defaults }
CGOPackageVersionCache >> packageDescriptionCache [
	[ ^ (MCCacheRepository uniqueInstance directory / 'package-descriptions') 
			ensureCreateDirectory; 
			yourself ]
	on: Error 
	do: [ Error signal: 'Can''t create a cache for package-description' ]
]

{ #category : #saving }
CGOPackageVersionCache >> saveDescription: aPackageVersion [
	| fileRef |
	aPackageVersion ifNil: [ ^ self ].
	fileRef := self packageDescriptionCache / aPackageVersion asString asLowercase.
	fileRef writeStreamDo: [ :stream | stream nextPutAll: (CGOPackageVersionWriterV1 toStringPretty: aPackageVersion) ]
	"Maybe we can have better performances by getting directly the STON string before the conversion in objects"
]
