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
		'registeredProjects'
	],
	#classVars : [
		'Default'
	],
	#category : 'CargoPackageManager-Minimal-Model'
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

{ #category : #conflicting }
CGOPackageRegistry >> conflictingProjectsWith: aCGOResolvedDependency [

	| cargoProjectConflicts metacelloProjectRegistration |
	cargoProjectConflicts := self registeredProjects select: [ :each | each isConflictingWith: aCGOResolvedDependency ].
	
	metacelloProjectRegistration := MetacelloProjectRegistration registry
		registrationForClassNamed: aCGOResolvedDependency name
		ifAbsent: [ ^ cargoProjectConflicts ].
	
	metacelloProjectRegistration
		baselineProjectSpecIfPresent: [ :baselineSpec |
			1halt: 'not yet implemented'.
			cargoProjectConflicts add: baselineSpec ]
		ifAbsent: [ "Nothing" ].
		
	metacelloProjectRegistration
		configurationProjectSpecIfPresent: [ :configurationSpec |
			cargoProjectConflicts add: (PBMetacelloConfigurationProjectDependency fromMetacelloSpec: configurationSpec) ]
		ifAbsent: [ "Nothing" ].
	
	^ cargoProjectConflicts
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
	
	^ installedPackages anySatisfy: [ :each | aPackageDependency isProvidedBy: each  ]
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
	project := CGOOngoingProject named: aString.
	self register: project.
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
		detect: [ :package | package name = aName asSymbol ]
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
CGOPackageRegistry >> register: aPackageVersion [
	aPackageVersion registry: self.
	self checkPackageNameRegistrationOf: aPackageVersion name.
	installedPackages add: aPackageVersion.
	self registerProject: aPackageVersion project.
	^ aPackageVersion
]

{ #category : #registering }
CGOPackageRegistry >> registerProject: aCGOProject [
	aCGOProject registry: self.
	(registeredProjects includes: aCGOProject)
		ifFalse: [ self checkProjectRegistrationOf: aCGOProject name.
					registeredProjects add: aCGOProject. ].
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

{ #category : #registering }
CGOPackageRegistry >> unregister: aPackageVersion [
	installedPackages remove: aPackageVersion ifAbsent: [ ^ self ].
	installedPackages 
		detect: [ :packageVersion | packageVersion project = aPackageVersion project ]
		ifNone: [ registeredProjects remove: aPackageVersion project ].
]
