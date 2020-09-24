"
This object represents a reference to a package version and knows how to get the referenced package version.

ex: 
	PackageVersionReference newOn: 'Seaside-Core@3.1.0'
"
Class {
	#name : #CGOPackageVersionReference,
	#superclass : #Object,
	#instVars : [
		'packageRepositories',
		'packageName',
		'version'
	],
	#category : #'CargoPackageManager-Minimal-Model'
}

{ #category : #'instance creation' }
CGOPackageVersionReference class >> newOn: aPackageVersionString [
	^ self new
		initializeWith: aPackageVersionString;
		yourself
]

{ #category : #'instance creation' }
CGOPackageVersionReference class >> packageName: aPackageName version: aVersionString [
	^ self new
		initializeWithName: aPackageName version: aVersionString;
		yourself
]

{ #category : #accessing }
CGOPackageVersionReference class >> packageVersionSeparator [
	^ $@ 
]

{ #category : #serialization }
CGOPackageVersionReference class >> stonName [
	^ #'PackageVersionReference'
]

{ #category : #comparing }
CGOPackageVersionReference >> = other [
	^ self class = other class 
		and: [ self packageName = other packageName 
			and: [ self versionString = other versionString ] ]
]

{ #category : #comparing }
CGOPackageVersionReference >> > other [
	^ self versionNumber > other versionNumber
]

{ #category : #converting }
CGOPackageVersionReference >> asPackageVersion [
	^ self fetchFromCache ifNil: [ self fetchFromRepositories ]
]

{ #category : #converting }
CGOPackageVersionReference >> asPackageVersionReference [
	^ self
]

{ #category : #fetching }
CGOPackageVersionReference >> fetchFromCache [
	"Search the package version description from the local cache"
	^ CGOPackageVersionCache new fetchDescription: self asString
]

{ #category : #fetching }
CGOPackageVersionReference >> fetchFromRepositories [
	packageRepositories ifEmpty: [ packageRepositories := Array with: Cargo defaultPackageRepository ].
	packageRepositories do: 
		[ :repository |
		[ ^ repository fetch: packageName version: version ]
			on: PBPackageNotFoundError, CGOPackageVersionNotFoundError
			do: [ "ignore, let's iterate on the next repository" ] ].
	CGOPackageVersionNotFoundError signal: 'Cannot find ' , self asString
]

{ #category : #initialization }
CGOPackageVersionReference >> initializeWith: aPackageVersionString [
	packageName := (aPackageVersionString copyUpTo: self class packageVersionSeparator) asSymbol.
	version := (aPackageVersionString copyAfterLast: self class packageVersionSeparator).
	version ifNotEmpty: [ version := version asSemanticVersion asString ].
	packageRepositories := #()
]

{ #category : #initialization }
CGOPackageVersionReference >> initializeWithName: aPackageName version: aVersionOrVersionString [
	packageName := aPackageName.
	version := aVersionOrVersionString asString.
	version ifNotEmpty: 
		[ version asSemanticVersion asString  "ensure semantic version is correct" ].
	packageRepositories := #()
]

{ #category : #accessing }
CGOPackageVersionReference >> packageName [
	^ packageName
]

{ #category : #accessing }
CGOPackageVersionReference >> packageRepositories: aPackageRepositoryList [
	packageRepositories := aPackageRepositoryList
]

{ #category : #printing }
CGOPackageVersionReference >> printOn: aStream [
	aStream << packageName.
	version ifNotEmpty: [ aStream << $@ << version ]
]

{ #category : #ston }
CGOPackageVersionReference >> stonOn: stonWriter [
	stonWriter writeString: self asString
]

{ #category : #accessing }
CGOPackageVersionReference >> versionNumber [
	^ version 
		ifEmpty: [ nil ]
		ifNotEmpty: [ version asSemanticVersion ]
]

{ #category : #accessing }
CGOPackageVersionReference >> versionString [
	^ version
]
