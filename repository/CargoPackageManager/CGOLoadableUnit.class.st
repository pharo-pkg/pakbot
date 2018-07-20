"
Abstract class representing a Cargo Package hosted in a Version Control System (e.g. git). 
It is used to update Cargo packages metadata.

- projectName is the name of the Cargo project I'm part of
"
Class {
	#name : #CGOLoadableUnit,
	#superclass : #Object,
	#instVars : [
		'dependencies',
		'name',
		'description'
	],
	#category : #'CargoPackageManager-Model'
}

{ #category : #'instance creation' }
CGOLoadableUnit class >> for: aPackageName [
	
	self deprecated: 'Please use #named: instead'
		transformWith: '`@receiver for: `@statements1' 
						-> '`@receiver named: `@statements1'.
	
	^ self named: aPackageName
]

{ #category : #'instance creation' }
CGOLoadableUnit class >> for: aPackageName project: aCargoProject [
	
	self deprecated: 'Please use #named:project: instead'
		transformWith: '`@receiver for: `@statements1 project: `@statements2' 
						-> '`@receiver named: `@statements1 project: `@statements2'.
	
	^ self named: aPackageName project: aCargoProject
]

{ #category : #'instance creation' }
CGOLoadableUnit class >> fromPackageVersion: aCGOPackageVersion [
	^ aCGOPackageVersion ongoingClass basicNew 
		initializeFromPackageVersion: aCGOPackageVersion
]

{ #category : #'instance creation' }
CGOLoadableUnit class >> fromStonString: aStonString [
	| reader version project |
	reader := STON reader on: aStonString readStream.
	version := reader next at: #version.
	project:= reader next.

	^ CGOPackageVersionWriterV1 deserializeProject: project version: version.
	

]

{ #category : #'instance creation' }
CGOLoadableUnit class >> named: aPackageName [
	^ self named: aPackageName project: nil 
]

{ #category : #'instance creation' }
CGOLoadableUnit class >> named: aPackageName project: aCargoProject [
	^ self basicNew
		initializeWithPackageName: aPackageName andProject: aCargoProject;
		yourself 
]

{ #category : #'as yet unclassified' }
CGOLoadableUnit class >> prepareClassQueriesFrom: aCollection in: aClyNavigationEnvironment [ 
	^#()
]

{ #category : #dependencies }
CGOLoadableUnit >> allDependencies [
	
	^ self subclassResponsibility
]

{ #category : #converting }
CGOLoadableUnit >> asOngoingPackageVersion [
	^ self
]

{ #category : #converting }
CGOLoadableUnit >> asPackageVersionOf: aCGOProject [
	self subclassResponsibility 
]

{ #category : #converting }
CGOLoadableUnit >> asPackageVersionReference [
	" version 0.0.0 means that the package has no version and comes from a VCS."
	^ CGOPackageVersionReference 
		packageName: self packageName 
		version: self version
]

{ #category : #accessing }
CGOLoadableUnit >> constraints [
	
	^ { CGOFixedVersionConstraint with: self version }
]

{ #category : #accessing }
CGOLoadableUnit >> description [
	
	^ description
]

{ #category : #accessing }
CGOLoadableUnit >> description: aString [ 
	
	description := aString
]

{ #category : #testing }
CGOLoadableUnit >> fitsPlatformRequirements [
	" True for assemblies (and so projects) and virtual packages as they do not have platform requirements."
	^ true
]

{ #category : #initialization }
CGOLoadableUnit >> initializeFromPackageVersion: aCGOPackageVersion [
	self subclassResponsibility
]

{ #category : #testing }
CGOLoadableUnit >> isAssembly [
	^ false
]

{ #category : #testing }
CGOLoadableUnit >> isMetacelloProject [
	^ false
]

{ #category : #testing }
CGOLoadableUnit >> isProject [
	^ false
]

{ #category : #testing }
CGOLoadableUnit >> isSolved [
	
	^ true
]

{ #category : #testing }
CGOLoadableUnit >> isUnit [
	^ false
]

{ #category : #testing }
CGOLoadableUnit >> isVirtual [
	^ false
]

{ #category : #accessing }
CGOLoadableUnit >> name [
	
	^ name
]

{ #category : #accessing }
CGOLoadableUnit >> name: aString [ 
	name := aString
]

{ #category : #printing }
CGOLoadableUnit >> printOn: aStream [
	super printOn: aStream.
	aStream nextPut: $(.
	aStream nextPutAll: self name.
	aStream nextPut: $).
]

{ #category : #accessing }
CGOLoadableUnit >> project [
	
	self subclassResponsibility
]

{ #category : #accessing }
CGOLoadableUnit >> projectName [
	^ self project name
]

{ #category : #'querying - installed' }
CGOLoadableUnit >> providesProject: aProjectDependency [ 
	
	"A package does not provide a project"
	^ false
]

{ #category : #accessing }
CGOLoadableUnit >> registry: aCGOPackageRegistry [ 
	"Do nothing by default. Only the project keeps a reference to the registry"
]

{ #category : #accessing }
CGOLoadableUnit >> repository [
	^ self project repository
]

{ #category : #'compatibility - cargo solver' }
CGOLoadableUnit >> version [

	^ self project version
]

{ #category : #'*CargoPackageManager' }
CGOLoadableUnit >> versionLoaded [
	"default: do nothing"
]
