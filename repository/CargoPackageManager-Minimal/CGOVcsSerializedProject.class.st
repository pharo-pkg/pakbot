"
I represent a Cargo project ready to be serialized on a Version Control System (e.g. git).
I map some instance variables  to an easily serialized form.
"
Class {
	#name : #CGOVcsSerializedProject,
	#superclass : #CGOVcsSerializedPackage,
	#category : #'CargoPackageManager-Minimal-Model-Serialization'
}

{ #category : #'instance creation' }
CGOVcsSerializedProject class >> from: aCGOOngoingProject [
	^ self basicNew
		initializeWithOngoing: aCGOOngoingProject;
		yourself
]

{ #category : #converting }
CGOVcsSerializedProject >> asOngoingPackage [
	^ PBProject fromVcsSerializedProject: self
]

{ #category : #converting }
CGOVcsSerializedProject >> asOngoingProject [
	"Flush information from this VcsSerializedProject into the provided CGOProject.
	All instance variables will be set with values from the SerializableProject"
	| project |
	
	dict 
		at: #name
		ifAbsent: [ PBError new 
						signal: 'Cannot deserialize a Project with no name defined!' ].
					
	project := PBProject named: (dict at: #name).
	dict at: #description ifPresent: [ :description | project description: description ].
	dict at: #units ifPresent: [ :units | 
		project packages: (self ongoingPackageUnitsFrom: units) ].
	dict at: #assemblies ifPresent: [ :assemblies | 
		project assemblies: (self ongoingPackageAssembliesFrom: assemblies) ].
	dict at: #virtualPackages ifPresent: [ :virtualPackages | 
		project virtualPackages: (self ongoingVirtualPackagesFrom: virtualPackages) ].
	dict at: #externalProjects ifPresent: [ :externalProjects | 
		project externalProjects: (self projectDependenciesFrom: externalProjects) ].
		
	project packages do: [:package | package project: project ].
	
	^ project 
]

{ #category : #deserialization }
CGOVcsSerializedProject >> gitRepositoryFrom: aDictionnary [ 
	^ CGOGitRepositoryCreator new
		url: (aDictionnary at: #repositoryUrl);
		version: (aDictionnary at: #version);
		create.
]

{ #category : #initialization }
CGOVcsSerializedProject >> initializeWithOngoing: aCGOOngoingProject [
	super initializeWithOngoing: aCGOOngoingProject.
	self
		addPropertyNamed: #externalProjects 
		ifNotEmptyOrNil: (aCGOOngoingProject externalProjects).
	self 
		addPropertyNamed: #units
		ifNotEmptyOrNil: (self sort: aCGOOngoingProject packageUnits andCollect: #asVcsSerializedPackageUnit).
	self
		addPropertyNamed: #assemblies 
		ifNotEmptyOrNil: (self sort: aCGOOngoingProject assemblies andCollect: #asVcsSerializedPackageAssembly).
	self 
		addPropertyNamed: #virtualPackages 
		ifNotEmptyOrNil: (self sort: aCGOOngoingProject virtualPackages andCollect: #asVcsSerializablePackageVersion).
]

{ #category : #deserialization }
CGOVcsSerializedProject >> ongoingPackageUnitsFrom: aCollection [
	^ aCollection collect: [ :each | (CGOVcsSerializedPackageUnit fromDictionary: each) asOngoingPackage ]	
]

{ #category : #deserialization }
CGOVcsSerializedProject >> pakbotProjectDependencyFrom: aDictionary [ 
	| repository |
	repository := self gitRepositoryFrom: (aDictionary at: #repository).
	^ PBPakbotProjectDependency 
		named: (aDictionary at: #name) 
		repositoryUrl: repository repositoryUrl
		version: (aDictionary at: #version)
		
]

{ #category : #deserialization }
CGOVcsSerializedProject >> projectDependenciesFrom: aCollection [ 
	^ aCollection collect: [ :projectDependencyDict | 
		(projectDependencyDict includesKey: #configuration)
			ifTrue: [ self configurationProjectDependencyFrom: projectDependencyDict ].
		(projectDependencyDict includesKey: #baseline)
			ifTrue: [ self baselineProjectDependencyFrom: projectDependencyDict ].
		self pakbotProjectDependencyFrom: projectDependencyDict. ]	
]

{ #category : #utility }
CGOVcsSerializedProject >> sort: packages andCollect: aSelector [
	^ (packages sorted: [ :a :b | a packageName < b packageName ])
			collect: aSelector 
]
