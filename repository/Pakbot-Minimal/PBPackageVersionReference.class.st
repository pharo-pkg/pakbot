"
This object represents a reference to a package version and knows how to get the referenced package version.

ex: 
	PackageVersionReference newOn: 'Seaside-Core@3.1.0'
"
Class {
	#name : #PBPackageVersionReference,
	#superclass : #Object,
	#instVars : [
		'packageRepositories',
		'packageName',
		'version'
	],
	#category : #'Pakbot-Minimal-Model'
}

{ #category : #'instance creation' }
PBPackageVersionReference class >> newOn: aPackageVersionString [
	^ self new
		initializeWith: aPackageVersionString;
		yourself
]

{ #category : #'instance creation' }
PBPackageVersionReference class >> packageName: aPackageName version: aVersionString [
	^ self new
		initializeWithName: aPackageName version: aVersionString;
		yourself
]

{ #category : #accessing }
PBPackageVersionReference class >> packageVersionSeparator [
	^ $@ 
]

{ #category : #serialization }
PBPackageVersionReference class >> stonName [
	^ #'PackageVersionReference'
]

{ #category : #comparing }
PBPackageVersionReference >> = other [
	^ self class = other class 
		and: [ self packageName = other packageName 
			and: [ self versionString = other versionString ] ]
]

{ #category : #comparing }
PBPackageVersionReference >> > other [
	^ self versionNumber > other versionNumber
]

{ #category : #converting }
PBPackageVersionReference >> asPackageVersion [
	^ self fetchFromCache ifNil: [ self fetchFromRepositories ]
]

{ #category : #converting }
PBPackageVersionReference >> asPackageVersionReference [
	^ self
]

{ #category : #fetching }
PBPackageVersionReference >> fetchFromCache [
	"Search the package version description from the local cache"
	^ CGOPackageVersionCache new fetchDescription: self asString
]

{ #category : #fetching }
PBPackageVersionReference >> fetchFromRepositories [
	packageRepositories ifEmpty: [ packageRepositories := Array with: Cargo defaultPackageRepository ].
	packageRepositories do: 
		[ :repository |
		[ ^ repository fetch: packageName version: version ]
			on: PBPackageNotFoundError, CGOPackageVersionNotFoundError
			do: [ "ignore, let's iterate on the next repository" ] ].
	CGOPackageVersionNotFoundError signal: 'Cannot find ' , self asString
]

{ #category : #initialization }
PBPackageVersionReference >> initializeWith: aPackageVersionString [
	packageName := (aPackageVersionString copyUpTo: self class packageVersionSeparator) asSymbol.
	version := (aPackageVersionString copyAfterLast: self class packageVersionSeparator).
	version ifNotEmpty: [ version := version asSemanticVersion asString ].
	packageRepositories := #()
]

{ #category : #initialization }
PBPackageVersionReference >> initializeWithName: aPackageName version: aVersionOrVersionString [
	packageName := aPackageName.
	version := aVersionOrVersionString asString.
	version ifNotEmpty: 
		[ version asSemanticVersion asString  "ensure semantic version is correct" ].
	packageRepositories := #()
]

{ #category : #accessing }
PBPackageVersionReference >> packageName [
	^ packageName
]

{ #category : #accessing }
PBPackageVersionReference >> packageRepositories: aPackageRepositoryList [
	packageRepositories := aPackageRepositoryList
]

{ #category : #printing }
PBPackageVersionReference >> printOn: aStream [
	aStream << packageName.
	version ifNotEmpty: [ aStream << $@ << version ]
]

{ #category : #ston }
PBPackageVersionReference >> stonOn: stonWriter [
	stonWriter writeString: self asString
]

{ #category : #accessing }
PBPackageVersionReference >> versionNumber [
	^ version 
		ifEmpty: [ nil ]
		ifNotEmpty: [ version asSemanticVersion ]
]

{ #category : #accessing }
PBPackageVersionReference >> versionString [
	^ version
]
