"
I represent a dependency to a project managed by a Metacello ConfigurationOf.
"
Class {
	#name : #PBMetacelloConfigurationProjectDependency,
	#superclass : #PBMetacelloProjectDependency,
	#category : #'CargoPackageManager-Minimal-Dependencies'
}

{ #category : #example }
PBMetacelloConfigurationProjectDependency class >> example [
	^ self
		name: 'JSON'
		repositoryUrl: 'http://smalltalkhub.com/mc/PharoExtras/JSON/main/'
		version: #stable
]

{ #category : #'instance-creation' }
PBMetacelloConfigurationProjectDependency class >> fromMetacelloSpec: aMetacelloSpec [ 
	^ self
		name: aMetacelloSpec name
		repositoryUrl: aMetacelloSpec repositories map values first description
		version: aMetacelloSpec versionString
]

{ #category : #accessing }
PBMetacelloConfigurationProjectDependency class >> iconName [
	^ #komitterSqueakSourceRemote
]

{ #category : #accessing }
PBMetacelloConfigurationProjectDependency class >> projectClass [
	^ PBMetacelloConfigurationProject 
]

{ #category : #'ston-core' }
PBMetacelloConfigurationProjectDependency class >> stonName [
	^ #MetacelloConfigurationProject
]

{ #category : #'querying - installed' }
PBMetacelloConfigurationProjectDependency >> isInstalledInMetacello [	
	| conf |
	conf := self metacelloProjectRegistry configurationRegistry 
		at: (#ConfigurationOf , name) 
		ifAbsent: [ ^ false ].	
	
	^ version isSymbol ifTrue: [  
		self isInstalledSymbolicVersion: conf.
	] ifFalse: [  
		conf version = version 
			and: [ conf loadedInImage 
			and: [ conf configurationProjectSpec loads isEmpty ] ]
	]
	
]

{ #category : #testing }
PBMetacelloConfigurationProjectDependency >> isInstalledSymbolicVersion: aMetacelloProjectRegistration [
	^ (aMetacelloProjectRegistration configurationProjectSpec projectClass project version: version) versionString = aMetacelloProjectRegistration version
]

{ #category : #testing }
PBMetacelloConfigurationProjectDependency >> isMetacelloConfiguration [
	^ true
]

{ #category : #'querying - installed' }
PBMetacelloConfigurationProjectDependency >> satisfyConstraints: aString [ 
	^ version = aString
]

{ #category : #ston }
PBMetacelloConfigurationProjectDependency >> stonMap [
	^ OrderedDictionary 
		with: 	#configuration -> name
		with:	#url -> url asString
		with: 	#version -> version
]

{ #category : #ston }
PBMetacelloConfigurationProjectDependency >> stonOn: stonWriter [
	stonWriter writeMap: self stonMap
]
