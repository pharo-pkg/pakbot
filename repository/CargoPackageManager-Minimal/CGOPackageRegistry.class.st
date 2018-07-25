"
Singleton pattern.
Registry used to hold description of packages installed in the image.

- installedPackages contains the list of all installed packges in the image.
- registeredProjects contains the list of projects having at least one of this package installed in the image
"
Class {
	#name : #CGOPackageRegistry,
	#superclass : #Object,
	#instVars : [
		'installedPackages',
		'registeredProjects',
		'systemPackageOrganizer'
	],
	#classVars : [
		'Default'
	],
	#category : #'CargoPackageManager-Minimal-Model'
}

{ #category : #accessing }
CGOPackageRegistry class >> default [
	^ Default
		ifNil: [ Default := self new ]
]

{ #category : #accessing }
CGOPackageRegistry class >> default: aCGOPackageRegistry [
	Default := aCGOPackageRegistry
]

{ #category : #private }
CGOPackageRegistry >> checkPackageNameRegistrationOf: aPackageName [
	^ [ self packageNamed: aPackageName.
		CGOPackageAlreadyRegistered signal: aPackageName , ' is already present in the registry!' ]
		on: CGOPackageNotFoundError
		do: [ "ignore: package not registered. It is safe to register a new one" ]
]

{ #category : #private }
CGOPackageRegistry >> checkProjectRegistrationOf: aProjectName [
	^ [ self projectNamed: aProjectName.
		CGOPackageAlreadyRegistered signal: aProjectName , ' is already a registered project in the registry!' ]
		on: CGOPackageNotFoundError
		do: [ "ignore: project not registered. It is safe to register a new one" ]
]

{ #category : #'compatilibility-repository' }
CGOPackageRegistry >> fetch: aPackageName version: aVersion [
	
	| package |
	package := self packageNamed: aPackageName.
	package version = aVersion asSemanticVersion
		ifFalse: [ CGOPackageVersionNotFoundError signal ].
	^ package
]

{ #category : #initialization }
CGOPackageRegistry >> initialize [
	super initialize.
	installedPackages := Set new.
	registeredProjects := Set new.
]

{ #category : #acccessing }
CGOPackageRegistry >> installedPackages [
	^ installedPackages
]

{ #category : #quering }
CGOPackageRegistry >> isInstalled: aPackageDependency [ 
	
	| found |
	found := self packageNamed: aPackageDependency fullyQualifiedName ifAbsent: [ ^ false ].
	^ aPackageDependency satisfyConstraints: found version 
]

{ #category : #testing }
CGOPackageRegistry >> isOutSync: anUnit [ 

	| found |
	found := self packageNamed: anUnit fullyQualifiedName ifAbsent: [ ^ false ].
	^ (anUnit satisfyConstraints: found version) not
]

{ #category : #testing }
CGOPackageRegistry >> isProjectInstalled: aCGOOngoingProject [ 
	
	^ registeredProjects includes: aCGOOngoingProject
]

{ #category : #'compatibility-repository' }
CGOPackageRegistry >> isVirtual: aString [ 
	
	^ (self packageNamed: aString) isVirtual
]

{ #category : #projects }
CGOPackageRegistry >> newProjectNamed: aString [ 
	
	| project |
	project := PBProject named: aString.
	self register: project.
	CGOProjectCreated announceOnProject: project.
	^ project
]

{ #category : #factory }
CGOPackageRegistry >> newSolver [
	
	^ CGOSolver new
		registry: self;
		yourself
]

{ #category : #acccessing }
CGOPackageRegistry >> packageNamed: aName [
	^ self 
		packageNamed: aName 
		ifAbsent: [ CGOPackageNotFoundError signal: aName asString ]
]

{ #category : #acccessing }
CGOPackageRegistry >> packageNamed: aName ifAbsent: absentBlock [
	^ installedPackages 
		detect: [ :package | package fullyQualifiedName = aName ]
		ifNone: absentBlock
]

{ #category : #acccessing }
CGOPackageRegistry >> projectNamed: aName [
	^ self 
		projectNamed: aName 
		ifAbsent: [ CGOPackageNotFoundError signal: aName asString ]
]

{ #category : #acccessing }
CGOPackageRegistry >> projectNamed: aName ifAbsent: absentBlock [
	^ registeredProjects 
		detect: [ :project | project name = aName asSymbol ]
		ifNone: absentBlock
]

{ #category : #registering }
CGOPackageRegistry >> register: aLoadableUnit [
	aLoadableUnit registry: self.
	self checkPackageNameRegistrationOf: aLoadableUnit fullyQualifiedName.
	installedPackages add: aLoadableUnit.
	
	(self isProjectInstalled: aLoadableUnit project)
		ifFalse: [ self registerProject: aLoadableUnit project ].
	^ aLoadableUnit
]

{ #category : #registering }
CGOPackageRegistry >> registerProject: aCGOProject [
	
	self checkProjectRegistrationOf: aCGOProject name.
	
	aCGOProject registry: self.
	registeredProjects add: aCGOProject.
	^ aCGOProject
]

{ #category : #acccessing }
CGOPackageRegistry >> registeredProjects [
	^ registeredProjects
]

{ #category : #cleaning }
CGOPackageRegistry >> reset [
	self initialize
]

{ #category : #acccessing }
CGOPackageRegistry >> systemPackageOrganizer [

	^ systemPackageOrganizer ifNil: [ RPackage organizer ]
]

{ #category : #accessing }
CGOPackageRegistry >> systemPackageOrganizer: aRPackageOrganizer [ 
	systemPackageOrganizer := aRPackageOrganizer
]

{ #category : #registering }
CGOPackageRegistry >> unregister: aPackageVersion [
	installedPackages remove: aPackageVersion ifAbsent: [ ^ self ].
	installedPackages 
		detect: [ :packageVersion | packageVersion project = aPackageVersion project ]
		ifNone: [ self unregisterProject: aPackageVersion project ].
		

]

{ #category : #registering }
CGOPackageRegistry >> unregisterProject: aProject [

	registeredProjects remove: aProject.
	installedPackages remove: aProject ifAbsent: ["Nothing To DO"].
	CGOProjectRemoved announceOnProject: aProject.
]
