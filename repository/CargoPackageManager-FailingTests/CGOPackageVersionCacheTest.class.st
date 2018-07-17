"
A PMPackageDescriptionCacheTest is a test class for testing the behavior of PMPackageDescriptionCache
"
Class {
	#name : #CGOPackageVersionCacheTest,
	#superclass : #CGOTest,
	#category : 'CargoPackageManager-FailingTests-Model'
}

{ #category : #'tests-decoding' }
CGOPackageVersionCacheTest >> testDecode [
	| fileRef |
	
	fileRef := FileLocator temp asFileReference / 'test.ston'.
	fileRef ensureDelete.
	fileRef writeStreamDo: [ :stream | stream nextPutAll: '[ 1, ''toto'']' ].
	self
		assert: (CGOPackageVersionCache new decode: fileRef)
		equals: #(1 'toto').
	fileRef delete.
]

{ #category : #'tests-decoding' }
CGOPackageVersionCacheTest >> testDecodeNonStonData [
	| fileRef |
	
	fileRef := FileLocator temp asFileReference / 'test.ston'.
	fileRef ensureDelete.
	fileRef writeStreamDo: [ :stream | stream nextPutAll: 'foo bar.' ].
	self
		assert: (CGOPackageVersionCache new decode: fileRef)
		equals: nil.
	fileRef delete.
]

{ #category : #'tests-fetching' }
CGOPackageVersionCacheTest >> testFetchDescription [
	| pkgVersionString pkgVersion stonDescription fileRef |
	
	pkgVersionString := 'Seaside-Core@3.1.0'.
	stonDescription := CGOPackageVersionWriterV1 toStringPretty: (self packageVersions detect: [:each | each asString = pkgVersionString ]).
	fileRef := CGOPackageVersionCache packageDescriptionCache asFileReference / pkgVersionString asLowercase.
	fileRef ensureDelete.
	fileRef writeStreamDo: [ :stream | stream nextPutAll: stonDescription ].
	pkgVersion := CGOPackageVersionCache new fetchDescription: pkgVersionString.
	self
		assert: (pkgVersion isKindOf: CGOPackageVersion).
	self
		assert: pkgVersion asString
		equals: pkgVersionString.
	fileRef delete
]

{ #category : #'tests-fetching' }
CGOPackageVersionCacheTest >> testFetchMissingDescription [
	self
		assert:	(CGOPackageVersionCache new fetchDescription: 'Seaside-Core@3.1.0')
		equals: nil.

]

{ #category : #'tests-defaults' }
CGOPackageVersionCacheTest >> testPackageDescriptionCache [
	self
		assert: CGOPackageVersionCache packageDescriptionCache exists
]

{ #category : #'tests-saving' }
CGOPackageVersionCacheTest >> testSaveDescription [
	| pkgVersionString pkgVersion fileRef |
	
	pkgVersionString := 'Seaside-Core@3.1.0'.
	pkgVersion := self packageVersions detect: [ :each | each asString = pkgVersionString ].
	CGOPackageVersionCache new saveDescription: pkgVersion.
	fileRef := CGOPackageVersionCache packageDescriptionCache asFileReference / pkgVersionString asLowercase.
	self assert: fileRef exists.
	fileRef delete
]
