"
I represent a version of a software project, e.g. Pakbot v1.0. 
I store basic metadata for the project.
A Pakbot project holds the list of assemblies (convenient and logical group of project packages) and virtual packages as well as the names of the package units (representing source code package) part of this project.
"
Class {
	#name : #PBProjectVersion,
	#superclass : #PBLoadableUnit,
	#instVars : [
		'assemblies',
		'virtualPackages',
		'repository',
		'registry',
		'externalProjects',
		'packages',
		'version'
	],
	#category : #'CargoPackageManager-Model'
}

{ #category : #example }
PBProjectVersion class >> example [
	^ (self named: #'MyProject')
		description: 'A simple project used for illustration.';
		packages: { PBPackage example };
		yourself
]

{ #category : #'instance creation' }
PBProjectVersion class >> for: aProjectName [
	
	self deprecated: 'Please use #named: instead'
		transformWith: '`@receiver for: `@statements1' 
						-> '`@receiver named: `@statements1'.
	
	^ self named: aProjectName
]

{ #category : #'instance creation' }
PBProjectVersion class >> fromRepository: aCGOSourceRepository [
	| ongoing |
	ongoing := self fromVcsStonString: aCGOSourceRepository projectMetadataStonString.
	ongoing repository: aCGOSourceRepository.
	^ ongoing
]

{ #category : #'instance creation' }
PBProjectVersion class >> fromVcsSerializedProject: aVcsSerializedProject [
	| ongoing |
	ongoing := self basicNew
		registry: PBPackageRegistry default;
		yourself.
	aVcsSerializedProject flushIn: ongoing.
	^ ongoing
]

{ #category : #'instance creation' }
PBProjectVersion class >> named: aProjectName [
	^ self basicNew
		initializeWithProjectName: aProjectName;
		yourself 
]

{ #category : #'instance creation' }
PBProjectVersion class >> new [

	self error: 'Please use #named:'
]

{ #category : #comparing }
PBProjectVersion >> = other [
	self species == other species ifFalse: [ ^ false ].
	^ self name = other name
]

{ #category : #assemblies }
PBProjectVersion >> addAssembly: anAssembly [
	(assemblies includes: anAssembly)
		ifTrue: [ PBPackageAlreadyRegistered signal ].		
	assemblies add: anAssembly.
	self announceChanged.

	^ anAssembly
]

{ #category : #assemblies }
PBProjectVersion >> addAssemblyNamed: aName [
	^ self addAssembly: 
		(PBAssembly 
			named: aName asSymbol
			project: self)
]

{ #category : #dependencies }
PBProjectVersion >> addDependency: aDependency [

	dependencies add: aDependency.
	aDependency project: self.
	
	self announceChangeInDependencies
]

{ #category : #updating }
PBProjectVersion >> addExternalProjectRequirement: aPBProjectDependencyDeclaration [ 
	externalProjects add: aPBProjectDependencyDeclaration.
	"for now, pakbot only supports project dependencies. Add these external projects as dependencies"
	self addDependency: aPBProjectDependencyDeclaration.
]

{ #category : #dependencies }
PBProjectVersion >> allDependencies [
	^ dependencies , (packages flatCollect: #allDependencies) asOrderedCollection.
]

{ #category : #dependencies }
PBProjectVersion >> announceChangeInDependencies [
	PBDependenciesChanged announceOnProject: self
]

{ #category : #packages }
PBProjectVersion >> announceChanged [

	PBProjectPartsChanged announceOnProject: self.
]

{ #category : #converting }
PBProjectVersion >> asCargoProject [
	^ CGOProject fromOngoing: self
]

{ #category : #converting }
PBProjectVersion >> asOngoingPackage [
	^ self
]

{ #category : #converting }
PBProjectVersion >> asSerializedPackage [
	"Package repository version of the project metadata (i.e. full metadata)"
	^ PBSerializedProject from: self
]

{ #category : #converting }
PBProjectVersion >> asVcsSerializedCargoProject [
	"VCS version of the project metadata (i.e. minimum metadata)"
	^ PBVcsSerializedProject from: self
]

{ #category : #accessing }
PBProjectVersion >> assemblies [
	^ assemblies
]

{ #category : #updating }
PBProjectVersion >> assemblies: aListOfPackageAssemblies [
	assemblies := aListOfPackageAssemblies
]

{ #category : #accessing }
PBProjectVersion >> assemblyNamed: aString [ 
	
	^ assemblies detect: [ :each | each name = aString ]
]

{ #category : #accessing }
PBProjectVersion >> authors [
	self flag: 'TODO'.
	" Use libigt to get the result of this command?
		git log 5c3843fd626b6ce88b74302ba9d2af6bc93904a9 --format='%aN' --reverse
	"
	^ #()
]

{ #category : #'private-loading' }
PBProjectVersion >> basicLoad [
	registry registerProject: self.
	self repository loadPackagesNamed: (self packageUnits 
		select: #isLoadable
		thenCollect: #name).
	PBProjectLoaded announceOnProject: self. 
]

{ #category : #'private-loading' }
PBProjectVersion >> basicLoad: aListOfPackageName [
	registry registerProject: self.
	(aListOfPackageName 
		collect: [ :pkgName | self packageOrAssemblyNamed: pkgName ]
		thenSelect: #isLoadable) 
			do: #basicLoad.
	PBProjectLoaded announceOnProject: self. 
]

{ #category : #accessing }
PBProjectVersion >> children [
	^ self packageUnits , self assemblies, self virtualPackages
]

{ #category : #packages }
PBProjectVersion >> createPackageNamed: aString [ 
	
	"We delegate to the system the creation of a package first.
	This will fail if a package with that name already exists.
	If that succeeds, we register that new package in this project."
	[ self systemPackageOrganizer createPackageNamed: aString ]
		on: RPackageConflictError
		do: [ :error | PBSystemPackageAlreadyDefined signal: aString ].

	^ self importPackageNamed: aString.
]

{ #category : #accessing }
PBProjectVersion >> defaultAssembly [

	^ (PBAssembly named: #default inProject: self)
		parts: packages copy;
		yourself
]

{ #category : #'API-dependencies' }
PBProjectVersion >> dependantProjects [
	
	^ registry dependantProjectsOf: self.
]

{ #category : #dependencies }
PBProjectVersion >> dependencies [
	
	^ dependencies
]

{ #category : #dependencies }
PBProjectVersion >> dependencies: aDependencyList [ 
	dependencies := aDependencyList.
	dependencies do: [ :dependency | dependency project: self ]
]

{ #category : #'API-dependencies' }
PBProjectVersion >> dependsOnProject: aPBProjectVersion [ 
	
	^ self resolve includesResolvedTarget: aPBProjectVersion 
]

{ #category : #publishing }
PBProjectVersion >> ensureIsTagged [
	"Ensure project version is already tagged, else tag the current version in the git repository."
	(self repository hasTagNamed: self version asString)
		ifFalse: [ self repository createTag: self version asString ]
]

{ #category : #accessing }
PBProjectVersion >> externalProjectNamed: aName [
	"replace dependencies by externalProjects?"
	^ dependencies
		detect: [ :dep | dep name = aName ]
		ifNone: [ PBPackageNotFoundError signal: aName ]
]

{ #category : #accessing }
PBProjectVersion >> externalProjects [
	^ externalProjects
]

{ #category : #updating }
PBProjectVersion >> externalProjects: aDictionnaryOfPBProjectDependencyDeclaration [  
	externalProjects := aDictionnaryOfPBProjectDependencyDeclaration
]

{ #category : #accessing }
PBProjectVersion >> fullyQualifiedName [

	 ^ self name
]

{ #category : #testing }
PBProjectVersion >> hasPackageNamed: aString [ 
	
	^ packages anySatisfy: [ :any | any name = aString ]
]

{ #category : #'polymorphism - PBMetacelloProject' }
PBProjectVersion >> hasPackagesLoaded: aListOfPackageNames [
	^ (self installedPackages collect: #name)
			includesAll: aListOfPackageNames
]

{ #category : #testing }
PBProjectVersion >> hasProblems [
	^ self isUpToDate not
]

{ #category : #testing }
PBProjectVersion >> hasRepository [
	
	^ repository isValidRepository
]

{ #category : #comparing }
PBProjectVersion >> hash [

	^ self name hash
]

{ #category : #'as yet unclassified' }
PBProjectVersion >> ifNotMarried: aBlock [
	repository isMarried
		ifFalse: [ aBlock value ]
]

{ #category : #packages }
PBProjectVersion >> importPackageNamed: aString [
	| package |
	package := self newNotLoadedPackage: aString.
	repository addPackageNamed: aString. "Bind the package with the new repository."
	^ registry register: package
]

{ #category : #packages }
PBProjectVersion >> importPackagesNamed: aCollection [ 
	
	aCollection do: [ :aName | self importPackageNamed: aName ]
]

{ #category : #initialization }
PBProjectVersion >> initialize [
	super initialize.
	repository := PBNoRepository new.
	version := PBNoVersion new.
	description := ''.
]

{ #category : #initialization }
PBProjectVersion >> initializeFromProject: aCGOProject [
	self initialize.
	description := aCGOProject description copy.
	packages := aCGOProject packageUnits collect: #asOngoingPackageVersion as: OrderedCollection.
	assemblies := aCGOProject assemblies veryDeepCopy asSet.
	virtualPackages := aCGOProject virtualPackages veryDeepCopy asSet.
	externalProjects := aCGOProject externalProjects veryDeepCopy asSet.
]

{ #category : #initialization }
PBProjectVersion >> initializeWithProjectName: aProjectName [
	"The packages is an OrderedCollection, the unicity of the elements is guarantee in other part of the code."
	
	self initialize.
	name := aProjectName.
	packages := OrderedCollection new.
	assemblies := Set new.
	virtualPackages := Set new.
	externalProjects := Set new.

]

{ #category : #accessing }
PBProjectVersion >> installedPackages [
	
	^ self packages select: [ :each | each isInstalled ]
]

{ #category : #accessing }
PBProjectVersion >> installedSystemPackages [
	
	^ self installedPackages collect: [ :each | each systemPackage ]
]

{ #category : #'compatibility - cargo solver' }
PBProjectVersion >> isAssembly [
	"Needed so that Cargo solver can use a project as a standard package assembly"
	^ true
]

{ #category : #conflicts }
PBProjectVersion >> isConflictingWith: aPBResolvedDependency [ 
	
	^ (self name = aPBResolvedDependency name)
		and: [ self ~= aPBResolvedDependency resolution resolvedProjectVersion ]
]

{ #category : #testing }
PBProjectVersion >> isEmpty [
	^ self packageNames isEmpty 
		and: [self assemblies isEmpty 
			and: [self virtualPackages isEmpty] ]
]

{ #category : #comparing }
PBProjectVersion >> isEquivalentTo: anotherProject [
	"This method is used when the comparison requires the resolution of the project"
	^ self = anotherProject 
]

{ #category : #testing }
PBProjectVersion >> isFixedVersion [
	^ version notNil and: [ (version major = 0 and: [ version minor = 0 and: [ version patch = 0 ] ]) not ]
]

{ #category : #testing }
PBProjectVersion >> isInstalled [
	
	^ self isLoaded
]

{ #category : #testing }
PBProjectVersion >> isLoaded [
	
	^ registry notNil
		and: [ registry isProjectInstalled: self ]
]

{ #category : #testing }
PBProjectVersion >> isProject [
	^ true
]

{ #category : #solving }
PBProjectVersion >> isResolvedBy: aResolution [
	
	^ aResolution resolvesProject: self
]

{ #category : #'querying - installed' }
PBProjectVersion >> isUpToDate [
	
	^ self allDependencies allSatisfy: [ :each | each isInstalled ]
]

{ #category : #'compatibility - package repository' }
PBProjectVersion >> isVirtual [
	^ false
]

{ #category : #loading }
PBProjectVersion >> load [
	
	self resolve load.
	self packages do: [ :package | registry register: package ].
	
	PBProjectLoaded announceOnProject: self. 
]

{ #category : #'polymorphism - PBMetacelloProject' }
PBProjectVersion >> loadedPackages [
	^ self installedPackages
]

{ #category : #updating }
PBProjectVersion >> marryWith: aPBGitRepository [
	"Marry this project with the referenced iceberg repository.
	It means iceberg project with be replaced by a PBIcebergProject referencing myself.
	It will allows to commit pakbot metadata through iceberg for a project not using pakbot before."
	
	self repository: aPBGitRepository.
	aPBGitRepository project:
		(PBIcebergProject
				onRepository: aPBGitRepository iceRepository
				project: self)
]

{ #category : #accessing }
PBProjectVersion >> metacelloProjects [
	^ externalProjects 
		select: #isMetacelloProjectDependency
		thenCollect: [ :projectDependency | PBMetacelloProject fromProjectDependency: projectDependency ]
]

{ #category : #packages }
PBProjectVersion >> newNotLoadedPackage: aString [ 
	| package |

	package := PBPackage named: aString asSymbol project: self.

	(packages includes: package)
		ifTrue: [ PBPackageAlreadyRegistered signal ].

	packages add: package.
	self announceChanged.
	
	^ package
]

{ #category : #updating }
PBProjectVersion >> newVirtualPackage: aName [
	| virtual |
	
	virtual := PBVirtualPackage 
		for: aName asSymbol 
		project: self.
	(virtualPackages includes: virtual)
		ifTrue: [ PBPackageAlreadyRegistered signal ].
	virtualPackages add: virtual.
	^ registry register: virtual
]

{ #category : #'system-interaction' }
PBProjectVersion >> packageCandidates [

	^ (registry systemPackageOrganizer packages
			reject: [ :each | self hasPackageNamed: each name ])
		asOrderedCollection
]

{ #category : #accessing }
PBProjectVersion >> packageNamed: aString [ 
	
	^ packages detect: [ :each | each name = aString ]
]

{ #category : #accessing }
PBProjectVersion >> packageNames [
	^ packages collect: #name
]

{ #category : #accessing }
PBProjectVersion >> packageOrAssemblyNamed: aString [ 
	
	^ [ self packageNamed: aString ]
		on: NotFound 
		do: [ self assemblyNamed: aString ]
]

{ #category : #accessing }
PBProjectVersion >> packageUnits [
	^ packages
]

{ #category : #accessing }
PBProjectVersion >> packages [

	^ packages
]

{ #category : #updating }
PBProjectVersion >> packages: aListOfPackageUnits [
	packages := aListOfPackageUnits asOrderedCollection.
	packages do: [ :each | each project: self ]
]

{ #category : #accessing }
PBProjectVersion >> pakbotProjectDependencies [
	^ externalProjects reject: #isMetacelloProjectDependency
]

{ #category : #printing }
PBProjectVersion >> printOn: aStream [
	aStream 
		<< self class name
		<< '('
		<< self name
		<< ')'
]

{ #category : #problems }
PBProjectVersion >> problemIcon [
	^ #error
]

{ #category : #problems }
PBProjectVersion >> problemLongDescription [
	self isUpToDate ifFalse: [ ^ 'One or more dependencies are not up to date.
Please update the whole project or fix the dependencies.'].
	
	^ ''
]

{ #category : #problems }
PBProjectVersion >> problemShortDescription [
	
	self isUpToDate ifFalse: [ ^ 'One or more dependencies are not up to date.' ].
	
	^ ''
]

{ #category : #accessing }
PBProjectVersion >> project [
	^ self
]

{ #category : #publishing }
PBProjectVersion >> publish [
	
	self publishOn: Cargo defaultPackageRepository
]

{ #category : #publishing }
PBProjectVersion >> publishOn: aPackageRepository [
	self hasRepository ifFalse: [ PBPublicationError signal: 'Cannot publish a Project with no repository defined!' ].
	self version isInvalid ifTrue: [ PBPublicationError signal: 'Cannot publish a Project with no version defined!' ].
	self ensureIsTagged.
	aPackageRepository saveProject: self.

]

{ #category : #accessing }
PBProjectVersion >> registry [
	^ registry
]

{ #category : #accessing }
PBProjectVersion >> registry: aCGOPackageRegistry [ 
	registry := aCGOPackageRegistry
]

{ #category : #assemblies }
PBProjectVersion >> removeAssembly: aPBAssembly [ 
	
	assemblies remove: aPBAssembly.	
	self announceChanged.
]

{ #category : #dependencies }
PBProjectVersion >> removeDependency: aDependency [
	dependencies remove: aDependency.
	self announceChangeInDependencies
]

{ #category : #packages }
PBProjectVersion >> removePackage: aPBPackage [ 
	
	packages remove: aPBPackage.
	assemblies do: [ :each | each removePackage: aPBPackage ifAbsent: [ "Nothing" ] ].
	self announceChanged.
]

{ #category : #removing }
PBProjectVersion >> removePart: aCGOPackageVersion [
	registry unregister: aCGOPackageVersion.

	assemblies 
		remove: aCGOPackageVersion
		ifAbsent: [ 	packages remove: aCGOPackageVersion ]
]

{ #category : #accessing }
PBProjectVersion >> repository [
	^ repository
]

{ #category : #updating }
PBProjectVersion >> repository: aPBSourceRepository [ 
	repository := aPBSourceRepository.
]

{ #category : #loading }
PBProjectVersion >> resolve [
	
	^ registry newSolver solveProject: self
]

{ #category : #solving }
PBProjectVersion >> resolvedDependency [ 
	
	"A PBProjectVersion is already solved, we need the version in the image"
	^ self
]

{ #category : #'system-interaction' }
PBProjectVersion >> systemPackageOrganizer [
	
	^ registry systemPackageOrganizer
]

{ #category : #unloading }
PBProjectVersion >> unload [
	
	registry unregisterProject: self
]

{ #category : #unloading }
PBProjectVersion >> unloadRemovingPackages [
	
	registry unregisterProject: self.
	packages do: [ :each | each removePackageFromSystem ]
]

{ #category : #accessing }
PBProjectVersion >> version [
	^ version
]

{ #category : #accessing }
PBProjectVersion >> version: anObject [
	version := anObject asSemanticVersion
]

{ #category : #accessing }
PBProjectVersion >> virtualPackages [
	^ virtualPackages
]

{ #category : #updating }
PBProjectVersion >> virtualPackages: aListOfVirtualPackages [ 
	virtualPackages := aListOfVirtualPackages
]

{ #category : #private }
PBProjectVersion >> withRepositoryDo: aBlock [
	repository 
		ifNil: [ CGOGitRepositoryCreationPanel withNewRepositoryDo: aBlock ]
		ifNotNil: [ aBlock value: repository ]
]
