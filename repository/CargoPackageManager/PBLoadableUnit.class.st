"
Abstract class representing a Cargo Package hosted in a Version Control System (e.g. git). 
It is used to update Cargo packages metadata.

- projectName is the name of the Cargo project I'm part of
"
Class {
	#name : #PBLoadableUnit,
	#superclass : #Object,
	#instVars : [
		'dependencies',
		'name',
		'description'
	],
	#category : #'CargoPackageManager-Model'
}

{ #category : #'instance creation' }
PBLoadableUnit class >> for: aPackageName [
	
	self deprecated: 'Please use #named: instead'
		transformWith: '`@receiver for: `@statements1' 
						-> '`@receiver named: `@statements1'.
	
	^ self named: aPackageName
]

{ #category : #'instance creation' }
PBLoadableUnit class >> for: aPackageName project: aCargoProject [
	
	self deprecated: 'Please use #named:project: instead'
		transformWith: '`@receiver for: `@statements1 project: `@statements2' 
						-> '`@receiver named: `@statements1 project: `@statements2'.
	
	^ self named: aPackageName project: aCargoProject
]

{ #category : #'instance creation' }
PBLoadableUnit class >> fromPackageVersion: aCGOPackageVersion [
	^ aCGOPackageVersion ongoingClass basicNew 
		initializeFromPackageVersion: aCGOPackageVersion
]

{ #category : #'instance creation' }
PBLoadableUnit class >> fromStonString: aStonString [
	| reader version project |
	reader := STON reader on: aStonString readStream.
	version := reader next at: #version.
	project:= reader next.

	^ PBPackageVersionWriterV1 deserializeProject: project version: version.
	

]

{ #category : #'instance creation' }
PBLoadableUnit class >> fromVcsStonString: aStonString [
	| reader version project |
	reader := STON reader on: aStonString readStream.
	version := reader next at: #version.
	project:= reader next.

	^ PBPackageVersionWriterV1 deserializeVcsProject: project version: version.
	

]

{ #category : #'instance creation' }
PBLoadableUnit class >> named: aPackageName [
	^ self named: aPackageName project: nil 
]

{ #category : #'instance creation' }
PBLoadableUnit class >> named: aPackageName project: aCargoProject [
	^ self basicNew
		initializeWithPackageName: aPackageName andProject: aCargoProject;
		yourself 
]

{ #category : #'as yet unclassified' }
PBLoadableUnit class >> prepareClassQueriesFrom: aCollection in: aClyNavigationEnvironment [ 
	^#()
]

{ #category : #dependencies }
PBLoadableUnit >> allDependencies [
	
	^ self subclassResponsibility
]

{ #category : #converting }
PBLoadableUnit >> asOngoingPackageVersion [
	^ self
]

{ #category : #converting }
PBLoadableUnit >> asPackageVersionReference [
	" version 0.0.0 means that the package has no version and comes from a VCS."
	^ CGOPackageVersionReference 
		packageName: self packageName 
		version: self version
]

{ #category : #accessing }
PBLoadableUnit >> constraints [
	
	^ { CGOFixedVersionConstraint with: self version }
]

{ #category : #accessing }
PBLoadableUnit >> description [
	
	^ description
]

{ #category : #accessing }
PBLoadableUnit >> description: aString [ 
	
	description := aString
]

{ #category : #testing }
PBLoadableUnit >> fitsPlatformRequirements [
	" True for assemblies (and so projects) and virtual packages as they do not have platform requirements."
	^ true
]

{ #category : #initialization }
PBLoadableUnit >> initialize [
	super initialize.
 	dependencies := OrderedCollection new.
	description := ''
]

{ #category : #initialization }
PBLoadableUnit >> initializeFromPackageVersion: aCGOPackageVersion [
	self subclassResponsibility
]

{ #category : #testing }
PBLoadableUnit >> isAssembly [
	^ false
]

{ #category : #testing }
PBLoadableUnit >> isMetacelloProject [
	^ false
]

{ #category : #testing }
PBLoadableUnit >> isProject [
	^ false
]

{ #category : #testing }
PBLoadableUnit >> isSolved [
	
	^ true
]

{ #category : #testing }
PBLoadableUnit >> isUnit [
	^ false
]

{ #category : #testing }
PBLoadableUnit >> isVirtual [
	^ false
]

{ #category : #accessing }
PBLoadableUnit >> name [
	
	^ name
]

{ #category : #accessing }
PBLoadableUnit >> name: aString [ 
	name := aString
]

{ #category : #printing }
PBLoadableUnit >> printOn: aStream [
	super printOn: aStream.
	aStream nextPut: $(.
	aStream nextPutAll: self name.
	aStream nextPut: $).
]

{ #category : #accessing }
PBLoadableUnit >> project [
	
	self subclassResponsibility
]

{ #category : #accessing }
PBLoadableUnit >> projectName [
	^ self project name
]

{ #category : #accessing }
PBLoadableUnit >> registry: aCGOPackageRegistry [ 
	"Do nothing by default. Only the project keeps a reference to the registry"
]

{ #category : #accessing }
PBLoadableUnit >> repository [
	^ self project repository
]

{ #category : #'compatibility - cargo solver' }
PBLoadableUnit >> version [

	^ self project version
]

{ #category : #'*CargoPackageManager' }
PBLoadableUnit >> versionLoaded [
	"default: do nothing"
]
