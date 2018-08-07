"
A PackageVersion represents a specific version (ex: 1.0) of a Package.
It has authors, contributors, dependencies, etc.

src represents the concrete atifact for this package containing source code.
ex: 
- package Foo may have a foo.Bob.68 (mcz) src artifac
- package Bar may have a foo (git folder) src artifact
"
Class {
	#name : #CGOPackageVersion,
	#superclass : #Object,
	#instVars : [
		'package',
		'description',
		'project',
		'timestamp'
	],
	#category : 'CargoPackageManager-Minimal-Model'
}

{ #category : #'instance creation' }
CGOPackageVersion class >> fromOngoing: aCGOOngoingPackage project: aCGOProject [
	^ self basicNew 
		initializeFromOngoing: aCGOOngoingPackage project: aCGOProject;
		yourself
]

{ #category : #'instance creation' }
CGOPackageVersion class >> fromStonString: aStonString [
	^ STON fromString: aStonString
]

{ #category : #'instance creation' }
CGOPackageVersion class >> newFrom: aDictionary [
	^ (aDictionary
			at: #parts
			ifPresent: [ :v | CGOPackageAssembly ]
			ifAbsent: [ CGOPackageUnit ])
				new
				initializeFrom: aDictionary
]

{ #category : #comparing }
CGOPackageVersion >> = other [
	(self class = other class) ifFalse: [ ^false ].
	(self name = other name) ifFalse: [ ^false ].
	(self version = other version) ifFalse: [ ^false ].
	^true
]

{ #category : #converting }
CGOPackageVersion >> asOngoingPackage [
	^ PBLoadableUnit fromPackageVersion: self
]

{ #category : #converting }
CGOPackageVersion >> asPackageVersionReference [
	^ CGOPackageVersionReference 
		packageName: self name 
		version: self version asString
]

{ #category : #converting }
CGOPackageVersion >> asSerializablePackageVersion [
	self shouldBeImplemented
]

{ #category : #accessing }
CGOPackageVersion >> dependencies [
	self shouldBeImplemented
]

{ #category : #accessing }
CGOPackageVersion >> description [
	^ description
]

{ #category : #comparing }
CGOPackageVersion >> hash [
	^ (self packageName , self version printString) hash
]

{ #category : #initialization }
CGOPackageVersion >> initializeFrom: aDictionary [
	super initialize.
	package := self packageFrom: aDictionary.
	description := aDictionary at: #description ifAbsent: ''.
	timestamp := DateAndTime now.
	project := aDictionary at: #project ifAbsent: [ CGOPackageVersionInitializationError signal: 'No  project found for this package version'].
]

{ #category : #initialization }
CGOPackageVersion >> initializeFromOngoing: aCGOOngoingPackage project: aCGOProject [
	description := aCGOOngoingPackage description copy.
	timestamp := DateAndTime now.

	package := aCGOOngoingPackage name.
	
	self assert: aCGOProject class = CGOProject.
	project := aCGOProject.

]

{ #category : #testing }
CGOPackageVersion >> isAssembly [
	^ false
]

{ #category : #testing }
CGOPackageVersion >> isDevelopmentVersion [
	^ self version isDevelopmentVersion
]

{ #category : #testing }
CGOPackageVersion >> isProject [
	^ false
]

{ #category : #testing }
CGOPackageVersion >> isUnit [
	^ false
]

{ #category : #testing }
CGOPackageVersion >> isVirtual [
	^ false
]

{ #category : #private }
CGOPackageVersion >> mandatoryKey: aKey from: aDictionary [
	^ aDictionary
		at: aKey
		ifPresent: [ :value |
			value ifNil: [ CGOPackageVersionInitializationError signal: 'No value provided for ' , aKey printString ] ]
		ifAbsent: [ CGOPackageVersionInitializationError signal: 'Cannot find the ', aKey printString , ' key!' ]
]

{ #category : #accessing }
CGOPackageVersion >> name [
	^ package
]

{ #category : #accessing }
CGOPackageVersion >> package [
	^ package 
]

{ #category : #'initialization - private' }
CGOPackageVersion >> packageFrom: aDictionary [
	| aSymbol |
	aSymbol := self mandatoryKey: #package from: aDictionary.
	aSymbol isSymbol
		ifFalse: [ CGOPackageVersionInitializationError signal: 'The package value must be a Symbol' ].
	^ CGOPackageProvider default packageNamed: aSymbol
]

{ #category : #accessing }
CGOPackageVersion >> packageName [
	^ package name
]

{ #category : #printing }
CGOPackageVersion >> printOn: aStream [
	aStream << self packageName << '@' << (self version asString)
]

{ #category : #accessing }
CGOPackageVersion >> project [
	^ project
]

{ #category : #private }
CGOPackageVersion >> projectFromSCM [
	self subclassResponsibility
]

{ #category : #publishing }
CGOPackageVersion >> publish [
	Cargo defaultPackageRepository
		savePackageVersion: self asPackageVersion
]

{ #category : #accessing }
CGOPackageVersion >> registry [
	^ project registry
]

{ #category : #accessing }
CGOPackageVersion >> timestamp [
	^ timestamp
]

{ #category : #accessing }
CGOPackageVersion >> version [
	^ project version
]
