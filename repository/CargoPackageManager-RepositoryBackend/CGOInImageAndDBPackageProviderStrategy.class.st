"
Strategy used to provides instances of Packages from the image and a database.
With this configuration, no new Package instance will be created in image before checking that there is not already the same package persisted in the database.
"
Class {
	#name : #CGOInImageAndDBPackageProviderStrategy,
	#superclass : #CGOInImagePackageProviderStrategy,
	#category : 'CargoPackageManager-RepositoryBackend'
}

{ #category : #private }
CGOInImageAndDBPackageProviderStrategy >> fetchFromDb: aSymbol [
	^ CGOPackage selectOne: [ :each | each name = aSymbol ]
]

{ #category : #providing }
CGOInImageAndDBPackageProviderStrategy >> packageNamed: aName [
	| packageName |
	packageName := aName asSymbol.
	^ packages 
		at: packageName
		ifAbsent: [ (self fetchFromDb: packageName) ifNil: [ self createPackage: packageName ] ]
]

{ #category : #providing }
CGOInImageAndDBPackageProviderStrategy >> virtualPackageNamed: aName [
	| package packageName |
	packageName := aName asSymbol.
	package := packages
		at: packageName
		ifAbsent: [ (self fetchFromDb: packageName) ifNil: [ self createVirtualPackage: packageName ] ].
	^ package isVirtual
		ifTrue: [ package ]
		ifFalse: [ self error: aName , ' is not a virtual package!']
]
