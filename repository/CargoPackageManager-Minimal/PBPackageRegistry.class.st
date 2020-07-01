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
		'installedPackages',
		'registeredProjects',
		'systemPackageOrganizer',
		'metacelloProjectRegistry'
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
PBPackageRegistry class >> default: aCGOPackageRegistry [
	
	self reset.
	Default := aCGOPackageRegistry
]

{ #category : #accessing }
PBPackageRegistry class >> reset [
	<script>
	Default ifNotNil: [ Default unregisterFromSystem. Default := nil ]
]

{ #category : #private }
PBPackageRegistry >> checkPackageNameRegistrationOf: aPackageName [
	
	(self hasInstalledPackageNamed: aPackageName)
		ifTrue: [ CGOPackageAlreadyRegistered signal: aPackageName , ' is already present in the registry!' ]

]

{ #category : #private }
PBPackageRegistry >> checkProjectRegistrationOf: aProjectName [
	(self hasProjectNamed: aProjectName)
		ifTrue: [ CGOPackageAlreadyRegistered
				signal: aProjectName , ' is already a registered project in the registry!' ]
]

{ #category : #'API -dependencies' }
PBPackageRegistry >> dependantProjectsOf: aPBProject [

	^ (registeredProjects
		select: [ :each | each ~= aPBProject and: [ each dependsOnProject: aPBProject ] ])
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

{ #category : #testing }
PBPackageRegistry >> hasProjectNamed: aName [

	^ registeredProjects anySatisfy: [ :each | each name = aName]
]

{ #category : #initialization }
PBPackageRegistry >> initialize [
	super initialize.
	installedPackages := Set new.
	registeredProjects := Set new.
]

{ #category : #accessing }
PBPackageRegistry >> installedPackages [
	^ installedPackages
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
PBPackageRegistry >> isOutSync: anUnit [ 

	| found |
	found := self packageNamed: anUnit fullyQualifiedName ifAbsent: [ ^ false ].
	^ (anUnit satisfyConstraints: found version) not
]

{ #category : #testing }
PBPackageRegistry >> isProjectInstalled: aCGOOngoingProject [ 
	
	^ registeredProjects includes: aCGOOngoingProject
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
	project := PBProject named: aString.
	self register: project.
	CGOProjectCreated announceOnProject: project.
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
		ifAbsent: [ CGOPackageNotFoundError signal: aName asString ]
]

{ #category : #accessing }
PBPackageRegistry >> packageNamed: aName ifAbsent: absentBlock [
	^ installedPackages 
		detect: [ :package | package fullyQualifiedName = aName ]
		ifNone: absentBlock
]

{ #category : #'system-events' }
PBPackageRegistry >> packageRenamed: aRPackageRenamed [ 

	| packages |
	
	packages := installedPackages select: [ :each | each name = aRPackageRenamed oldName ].
	packages do: [ :each | each name: aRPackageRenamed newName. each project announceChanged ]

]

{ #category : #'system-events' }
PBPackageRegistry >> packageUnregistered: aRPackageUnregistered [ 

	| packages |
	
	packages := installedPackages select: [ :each | each name = aRPackageUnregistered package name ].
	installedPackages removeAll: packages.
	
	packages do: [ :each | each project announceChanged ]

]

{ #category : #accessing }
PBPackageRegistry >> projectNamed: aName [
	^ self 
		projectNamed: aName 
		ifAbsent: [ CGOPackageNotFoundError signal: aName asString ]
]

{ #category : #accessing }
PBPackageRegistry >> projectNamed: aName ifAbsent: absentBlock [
	^ registeredProjects 
		detect: [ :project | project name = aName asSymbol ]
		ifNone: absentBlock
]

{ #category : #registering }
PBPackageRegistry >> register: aLoadableUnit [
	aLoadableUnit registry: self.
	self checkPackageNameRegistrationOf: aLoadableUnit fullyQualifiedName.
	installedPackages add: aLoadableUnit.
	
	(self isProjectInstalled: aLoadableUnit project)
		ifFalse: [ self registerProject: aLoadableUnit project ].
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
PBPackageRegistry >> registerProject: aCGOProject [
	
	self checkProjectRegistrationOf: aCGOProject name.
	
	aCGOProject registry: self.
	registeredProjects add: aCGOProject.
	^ aCGOProject
]

{ #category : #accessing }
PBPackageRegistry >> registeredProjects [
	^ registeredProjects
]

{ #category : #cleaning }
PBPackageRegistry >> reset [
	self initialize
]

{ #category : #accessing }
PBPackageRegistry >> systemPackageOrganizer [

	^ systemPackageOrganizer ifNil: [ RPackage organizer ]
]

{ #category : #accessing }
PBPackageRegistry >> systemPackageOrganizer: aRPackageOrganizer [ 
	systemPackageOrganizer := aRPackageOrganizer
]

{ #category : #registering }
PBPackageRegistry >> unregister: aPackageVersion [
	installedPackages remove: aPackageVersion ifAbsent: [ ^ self ].
	installedPackages 
		detect: [ :packageVersion | packageVersion project = aPackageVersion project ]
		ifNone: [ self unregisterProject: aPackageVersion project ].
		

]

{ #category : #'system-announcements' }
PBPackageRegistry >> unregisterFromSystem [

	SystemAnnouncer uniqueInstance unsubscribe: self
]

{ #category : #registering }
PBPackageRegistry >> unregisterProject: aProject [

	registeredProjects remove: aProject.
	installedPackages remove: aProject ifAbsent: ["Nothing To DO"].
	
	aProject packages do: [ :each | installedPackages remove: each ifAbsent: [  ] ].
	
	CGOProjectRemoved announceOnProject: aProject.
]
