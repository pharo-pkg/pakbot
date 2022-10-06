"
Singleton pattern.
Registry used to hold description of packages installed in the image.

- installedPackages contains the list of all installed packges in the image.
- registeredProjects contains the list of projects having at least one of this package installed in the image
- metacelloProjectRegistry is a reference to the metacello project registry. It allows to use a custom registry for tests.
"
Class {
	#name : #PBPackageRegistry,
	#superclass : #Object,
	#instVars : [
		'registeredProjects',
		'systemPackageOrganizer',
		'metacelloProjectRegistry',
		'platformRequirements'
	],
	#classVars : [
		'Default'
	],
	#category : #'CargoPackageManager-Minimal-Model'
}

{ #category : #accessing }
PBPackageRegistry class >> default [
	^ Default
		ifNil: [ Default := self new registerInSystem; yourself ]
]

{ #category : #accessing }
PBPackageRegistry class >> default: aPBPackageRegistry [
	
	self reset.
	Default := aPBPackageRegistry
]

{ #category : #accessing }
PBPackageRegistry class >> reset [
	<script>
	Default ifNotNil: [ Default unregisterFromSystem. Default := nil ]
]

{ #category : #helper }
PBPackageRegistry class >> useDefaultRegistry: aPBPackageRegistry during: aBlock [
	| default |
	default := self default.
	[ self default: aPBPackageRegistry.
	aBlock value ]
		ensure: [ self default: default ]
]

{ #category : #private }
PBPackageRegistry >> checkProjectRegistrationOf: aPBProjectVersion [

	| installedProject |
	(self isProjectRegistered: aPBProjectVersion) ifFalse: [ ^ self ].

	installedProject := self projectNamed: aPBProjectVersion name.
	(installedProject version = aPBProjectVersion version and: [ 
		 installedProject repository = aPBProjectVersion repository ]) 
		ifTrue: [ ^ self ].
	self signalAlreadyRegistered: aPBProjectVersion
]

{ #category : #accessing }
PBPackageRegistry >> currentPlatformRequirements [
	^ platformRequirements ifNil: [ platformRequirements := PBPlatformAttributes new ]
]

{ #category : #'API -dependencies' }
PBPackageRegistry >> dependantProjectsOf: aPBProjectVersion [

	^ (registeredProjects
		select: [ :each | each ~= aPBProjectVersion and: [ each dependsOnProject: aPBProjectVersion ] ])
		asOrderedCollection
]

{ #category : #'compatibility-repository' }
PBPackageRegistry >> fetch: aPackageName version: aVersion [
	
	| package |
	package := self packageNamed: aPackageName.
	package version = aVersion asSemanticVersion
		ifFalse: [ CGOPackageVersionNotFoundError signal ].
	^ package
]

{ #category : #testing }
PBPackageRegistry >> hasInstalledPackageNamed: fullyQualifiedName [

	^ self installedPackages anySatisfy: [ :each | each fullyQualifiedName = fullyQualifiedName]
]

{ #category : #initialization }
PBPackageRegistry >> initialize [
	super initialize.
	registeredProjects := Set new.
]

{ #category : #accessing }
PBPackageRegistry >> installedPackages [

	^ self registeredProjects flatCollect: [ :project | project installedPackages ] 
]

{ #category : #quering }
PBPackageRegistry >> isInstalled: aDependency [ 
	
	| found |
	found := self packageNamed: aDependency fullyQualifiedName ifAbsent: [ 
			self projectNamed: aDependency fullyQualifiedName ifAbsent: [ ^ false ]
		 ].
	
	^ aDependency satisfyConstraints: found version 
]

{ #category : #testing }
PBPackageRegistry >> isOutOfSync: anUnit [ 

	| found |
	found := self packageNamed: anUnit fullyQualifiedName ifAbsent: [ ^ false ].
	^ (anUnit satisfyConstraints: found version) not
]

{ #category : #testing }
PBPackageRegistry >> isProjectRegistered: aPBProjectVersion [
	
	^ registeredProjects includes: aPBProjectVersion
]

{ #category : #'compatibility-repository' }
PBPackageRegistry >> isVirtual: aString [ 
	
	^ (self packageNamed: aString) isVirtual
]

{ #category : #accessing }
PBPackageRegistry >> metacelloProjectRegistry [
	^ metacelloProjectRegistry ifNil: [ MetacelloProjectRegistration registry ]
]

{ #category : #accessing }
PBPackageRegistry >> metacelloProjectRegistry: aMetacelloProjectRegistry [
	metacelloProjectRegistry := aMetacelloProjectRegistry
]

{ #category : #projects }
PBPackageRegistry >> newProjectNamed: aString [ 
	
	| project |
	project := PBProjectVersion named: aString.
	self registerProject: project.
	PBProjectCreated announceOnProject: project.
	^ project
]

{ #category : #factory }
PBPackageRegistry >> newSolver [
	
	^ PBSolver new
		registry: self;
		yourself
]

{ #category : #accessing }
PBPackageRegistry >> packageNamed: aName [
	^ self 
		packageNamed: aName 
		ifAbsent: [ PBPackageNotFoundError signal: aName asString ]
]

{ #category : #accessing }
PBPackageRegistry >> packageNamed: aName ifAbsent: absentBlock [
	^ self installedPackages 
		detect: [ :package | package fullyQualifiedName = aName ]
		ifNone: absentBlock
]

{ #category : #'system-events' }
PBPackageRegistry >> packageRenamed: aRPackageRenamed [ 

	| packages |
	
	packages := self installedPackages select: [ :each | each name = aRPackageRenamed oldName ].
	packages do: [ :each | each name: aRPackageRenamed newName. each project announceChanged ]

]

{ #category : #'system-events' }
PBPackageRegistry >> packageUnregistered: aRPackageUnregistered [ 

	self installedPackages 
		select: [ :each | each name = aRPackageUnregistered package name ]
		thenDo: [ :each | each project announceChanged ]
]

{ #category : #accessing }
PBPackageRegistry >> projectNamed: aName [
	^ self 
		projectNamed: aName 
		ifAbsent: [ PBPackageNotFoundError signal: aName asString ]
]

{ #category : #accessing }
PBPackageRegistry >> projectNamed: aName ifAbsent: absentBlock [
	^ registeredProjects 
		detect: [ :project | project name = aName asSymbol ]
		ifNone: absentBlock
]

{ #category : #registering }
PBPackageRegistry >> register: aLoadableUnit [

	self registerProject: aLoadableUnit project.
	^ aLoadableUnit
]

{ #category : #'system-announcements' }
PBPackageRegistry >> registerInSystem [
	SystemAnnouncer uniqueInstance
		when: RPackageUnregistered
		send: #packageUnregistered:
		to: self.
	SystemAnnouncer uniqueInstance
		when: RPackageRenamed
		send: #packageRenamed:
		to: self
]

{ #category : #registering }
PBPackageRegistry >> registerProject: aPBProjectVersion [
	| registeredProject |
	
	" only raise an exception if 
	- installedProject does not refer to the same version / repository
	- aPBProjectVersion is already registered and all its packages loaded "

	(self isProjectRegistered: aPBProjectVersion) 
		ifFalse: [ aPBProjectVersion registry: self.
					registeredProjects add: aPBProjectVersion.
					^ aPBProjectVersion ].
	
	registeredProject := self projectNamed: aPBProjectVersion name.
	
	(registeredProject version = aPBProjectVersion version
		and: [ registeredProject repository = aPBProjectVersion repository ])
			ifFalse: [ self signalAlreadyRegistered: aPBProjectVersion ].
	
	aPBProjectVersion registry: self.
	registeredProject beInstalledWithPackages: aPBProjectVersion loadedPackages.
	^ registeredProject
]

{ #category : #accessing }
PBPackageRegistry >> registeredProjects [
	^ registeredProjects
]

{ #category : #cleaning }
PBPackageRegistry >> reset [
	self initialize
]

{ #category : #registering }
PBPackageRegistry >> signalAlreadyRegistered: aPBProjectVersion [

	PBPackageAlreadyRegistered 
		signal: aPBProjectVersion name , ' is already a registered project in the registry!'
]

{ #category : #accessing }
PBPackageRegistry >> systemPackageOrganizer [

	^ systemPackageOrganizer ifNil: [ RPackage organizer ]
]

{ #category : #accessing }
PBPackageRegistry >> systemPackageOrganizer: aRPackageOrganizer [ 
	systemPackageOrganizer := aRPackageOrganizer
]

{ #category : #'system-announcements' }
PBPackageRegistry >> unregisterFromSystem [

	SystemAnnouncer uniqueInstance unsubscribe: self
]

{ #category : #registering }
PBPackageRegistry >> unregisterProject: aProject [

	registeredProjects remove: aProject.
	PBProjectRemoved announceOnProject: aProject.
]
