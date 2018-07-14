"
Abstract class representing a Cargo Package hosted in a Version Control System (e.g. git). 
It is used to update Cargo packages metadata.

- projectName is the name of the Cargo project I'm part of
"
Class {
	#name : #CGOOngoingPackage,
	#superclass : #Object,
	#instVars : [
		'package',
		'description',
		'project',
		'version'
	],
	#category : 'CargoPackageManager-Model'
}

{ #category : #'instance creation' }
CGOOngoingPackage class >> for: aPackageName [
	^ self for: aPackageName project: nil 
]

{ #category : #'instance creation' }
CGOOngoingPackage class >> for: aPackageName project: aCargoProject [
	^ self basicNew
		initializeWithPackageName: aPackageName andProject: aCargoProject;
		yourself 
]

{ #category : #'instance creation' }
CGOOngoingPackage class >> fromPackageVersion: aCGOPackageVersion [
	^ aCGOPackageVersion ongoingClass basicNew 
		initializeFromPackageVersion: aCGOPackageVersion
]

{ #category : #'instance creation' }
CGOOngoingPackage class >> fromStonString: aStonString [
	^ (STON fromString: aStonString) asOngoingPackage 
]

{ #category : #'as yet unclassified' }
CGOOngoingPackage class >> prepareClassQueriesFrom: aCollection in: aClyNavigationEnvironment [ 
	^#()
]

{ #category : #comparing }
CGOOngoingPackage >> = other [
	^ self class == other class 
		ifTrue: [ package == other package and: [ project = other project ] ]
		ifFalse: [ ^ false ]	
]

{ #category : #dependencies }
CGOOngoingPackage >> allDependencies [
	
	^ self subclassResponsibility
]

{ #category : #converting }
CGOOngoingPackage >> asOngoingPackageVersion [
	^ self
]

{ #category : #converting }
CGOOngoingPackage >> asPackageVersionOf: aCGOProject [
	self subclassResponsibility 
]

{ #category : #converting }
CGOOngoingPackage >> asPackageVersionReference [
	" version 0.0.0 means that the package has no version and comes from a VCS."
	^ CGOPackageVersionReference 
		packageName: self packageName 
		version: self version
]

{ #category : #accessing }
CGOOngoingPackage >> constraints [
	
	^ { CGOFixedVersionConstraint with: self version }
]

{ #category : #accessing }
CGOOngoingPackage >> description [
	^ description
]

{ #category : #accessing }
CGOOngoingPackage >> description: aString [
	description := aString
]

{ #category : #'private - deserialization' }
CGOOngoingPackage >> deserializedDependencies: aListOfSerializedDependencies [
	^ aListOfSerializedDependencies 
		ifNil: [ OrderedCollection empty ]
		ifNotNil: [ aListOfSerializedDependencies collect:
				[ :associationOrString | | association |
					association := associationOrString isString 
						ifTrue: [ associationOrString -> #() ]
						ifFalse: [ associationOrString ].
					CGOPackageDependency newFrom: association ] ]
]

{ #category : #testing }
CGOOngoingPackage >> fitsPlatformRequirements [
	" True for assemblies (and so projects) and virtual packages as they do not have platform requirements."
	^ true
]

{ #category : #comparing }
CGOOngoingPackage >> hash [
	^ self packageName hash bitXor: self project hash
]

{ #category : #initialization }
CGOOngoingPackage >> initialize [
	super initialize.
	version := '0.0.0-N/A' asSemanticVersion
]

{ #category : #initialization }
CGOOngoingPackage >> initializeFromPackageVersion: aCGOPackageVersion [
	self subclassResponsibility
]

{ #category : #initialization }
CGOOngoingPackage >> initializeWithPackageName: aPackageName andProject: aCargoProject [
	self initialize.
	package := CGOPackageProvider default packageNamed: aPackageName.
	description := ''.
	project := aCargoProject
]

{ #category : #testing }
CGOOngoingPackage >> isAssembly [
	^ false
]

{ #category : #testing }
CGOOngoingPackage >> isMetacelloProject [
	^ false
]

{ #category : #testing }
CGOOngoingPackage >> isProject [
	^ false
]

{ #category : #testing }
CGOOngoingPackage >> isSolved [
	
	^ true
]

{ #category : #testing }
CGOOngoingPackage >> isUnit [
	^ false
]

{ #category : #testing }
CGOOngoingPackage >> isVirtual [
	^ false
]

{ #category : #accessing }
CGOOngoingPackage >> package [
	^ package
]

{ #category : #updating }
CGOOngoingPackage >> package: aPackageName [
	aPackageName isSymbol
		ifFalse: [ CGOPackageVersionInitializationError signal: 'The package value must be a Symbol' ].
	package := CGOPackageProvider default packageNamed: aPackageName
]

{ #category : #accessing }
CGOOngoingPackage >> packageName [
	^ package 
		ifNil: [ 'N/A' ] 
		ifNotNil: [ package name ]
]

{ #category : #printing }
CGOOngoingPackage >> printOn: aStream [
	super printOn: aStream.
	aStream nextPut: $(.
	aStream nextPutAll: self packageName.
	aStream nextPut: $).
]

{ #category : #accessing }
CGOOngoingPackage >> project [
	^ project
]

{ #category : #accessing }
CGOOngoingPackage >> project: aCGOOngoingProject [
	project := aCGOOngoingProject
]

{ #category : #accessing }
CGOOngoingPackage >> projectName [
	^ self project packageName
]

{ #category : #'querying - installed' }
CGOOngoingPackage >> providesProject: aProjectDependency [ 
	
	"A package does not provide a project"
	^ false
]

{ #category : #accessing }
CGOOngoingPackage >> registry: aCGOPackageRegistry [ 
	"Do nothing by default. Only the project keeps a reference to the registry"
]

{ #category : #accessing }
CGOOngoingPackage >> repository [
	^ self project repository
]

{ #category : #'compatibility - cargo solver' }
CGOOngoingPackage >> version [

	^ version
]

{ #category : #'compatibility - cargo solver' }
CGOOngoingPackage >> version: aVersion [

	version := aVersion
]

{ #category : #'*CargoPackageManager' }
CGOOngoingPackage >> versionLoaded [
	"default: do nothing"
]
