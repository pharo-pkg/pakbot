"
I represent a software project. I store basic metadata for the project.
A Cargo project holds the list of assemblies (convenient and logical group of project packages) and virtual packages as well as the names of the package units (representing source code package) part of this project.
"
Class {
	#name : #CGOOngoingProject,
	#superclass : #CGOOngoingPackage,
	#instVars : [
		'units',
		'assemblies',
		'virtualPackages',
		'repository',
		'registry',
		'externalProjects',
		'systemPackageOrganizer',
		'dependencies'
	],
	#category : 'CargoPackageManager-Model'
}

{ #category : #example }
CGOOngoingProject class >> example [
	^ (self named: #'MyProject')
		description: 'A simple project used for illustration.';
		packageUnits: { CGOOngoingPackageUnit example };
		yourself
]

{ #category : #'instance creation' }
CGOOngoingProject class >> for: aProjectName [
	
	self deprecated: 'Please use #named: instead'
		transformWith: '`@receiver for: `@statements1' 
						-> '`@receiver named: `@statements1'.
	
	^ self named: aProjectName
]

{ #category : #'instance creation' }
CGOOngoingProject class >> fromRepository: aCGOSourceRepository [
	| ongoing |
	ongoing := self fromStonString: aCGOSourceRepository projectMetadataStonString.
	ongoing repository: aCGOSourceRepository.
	^ ongoing
]

{ #category : #'instance creation' }
CGOOngoingProject class >> fromVcsSerializedProject: aVcsSerializedProject [
	| ongoing |
	ongoing := self basicNew
		registry: CGOPackageRegistry default;
		yourself.
	aVcsSerializedProject flushIn: ongoing.
	^ ongoing
]

{ #category : #'instance creation' }
CGOOngoingProject class >> named: aProjectName [
	^ self basicNew
		initializeWithProjectName: aProjectName;
		yourself 
]

{ #category : #'instance creation' }
CGOOngoingProject class >> new [

	self error: 'Please use #named:'
]

{ #category : #comparing }
CGOOngoingProject >> = other [
	^ self class == other class 
		ifTrue: [ package == other package ]
		ifFalse: [ ^ false ]	
]

{ #category : #dependencies }
CGOOngoingProject >> addDependency: aDependency [

	dependencies add: aDependency.
	aDependency project: self.
	
	CGODependenciesChanged announceOnProject: self. 
]

{ #category : #updating }
CGOOngoingProject >> addExternalCargoProject: aCGOProjectDependencyDeclaration [ 
	externalProjects add: aCGOProjectDependencyDeclaration
]

{ #category : #dependencies }
CGOOngoingProject >> allDependencies [
	^ dependencies , (units flatCollect: #allDependencies).
]

{ #category : #converting }
CGOOngoingProject >> asCargoProject [
	^ CGOProject fromOngoing: self
]

{ #category : #converting }
CGOOngoingProject >> asOngoingPackage [
	^ self
]

{ #category : #converting }
CGOOngoingProject >> asSerializedCargoProject [
	"VCS version of the project metadata (i.e. minimum metadata)"
	^ CGOVcsSerializedProject from: self
]

{ #category : #converting }
CGOOngoingProject >> asVcsSerializedCargoProject [
	"VCS version of the project metadata (i.e. minimum metadata)"
	^ CGOVcsSerializedProject from: self
]

{ #category : #accessing }
CGOOngoingProject >> assemblies [
	^ assemblies
]

{ #category : #updating }
CGOOngoingProject >> assemblies: aListOfPackageAssemblies [
	assemblies := aListOfPackageAssemblies
]

{ #category : #accessing }
CGOOngoingProject >> authors [
	self flag: 'TODO'.
	" Use libigt to get the result of this command?
		git log 5c3843fd626b6ce88b74302ba9d2af6bc93904a9 --format='%aN' --reverse
	"
	^ #()
]

{ #category : #loading }
CGOOngoingProject >> basicLoad [
	registry registerProject: self.
	self packageUnits do: #load.
	CGOProjectLoaded announceOnProject: self. 
]

{ #category : #accessing }
CGOOngoingProject >> cargoProjectDependencies [
	^ externalProjects reject: #isMetacelloProjectDependency
]

{ #category : #adding }
CGOOngoingProject >> createNewPackageNamed: aString [ 
	
	"We delegate to the system the creation of a package first.
	This will fail if a package with that name already exists.
	If that succeeds, we register that new package in this project."
	[ self systemPackageOrganizer createPackageNamed: aString ]
		on: RPackageConflictError
		do: [ :error | CGOSystemPackageAlreadyDefined signal: aString ].

	self newPackageUnit: aString.
]

{ #category : #accessing }
CGOOngoingProject >> defaultAssembly [

	^ (CGOOngoingPackageAssembly named: #default inProject: self)
		parts: units copy;
		yourself
]

{ #category : #dependencies }
CGOOngoingProject >> dependencies [
	
	^ dependencies
]

{ #category : #dependencies }
CGOOngoingProject >> dependencies: aDependencyList [ 
	dependencies := aDependencyList
]

{ #category : #accessing }
CGOOngoingProject >> externalProjects [
	^ externalProjects
]

{ #category : #updating }
CGOOngoingProject >> externalProjects: aDictionnaryOfCGOProjectDependencyDeclaration [  
	externalProjects := aDictionnaryOfCGOProjectDependencyDeclaration
]

{ #category : #ston }
CGOOngoingProject >> fromSton: stonReader [
	"Decode the Cargo serialized project."
	| serializedProject |
	
	serializedProject := CGOVcsSerializedProject new fromSton: stonReader.
	self registry: CGOPackageRegistry default.
	serializedProject flushIn: self.
]

{ #category : #testing }
CGOOngoingProject >> hasPackageNamed: aString [ 
	
	^ units anySatisfy: [ :any | any packageName = aString ]
]

{ #category : #testing }
CGOOngoingProject >> hasProblems [
	^ self isUpToDate not
]

{ #category : #comparing }
CGOOngoingProject >> hash [
	^ self packageName hash
]

{ #category : #adding }
CGOOngoingProject >> importPackageNamed: aString [ 
	
	self newPackageUnit: aString
]

{ #category : #initialization }
CGOOngoingProject >> initializeFromProject: aCGOProject [
	super initialize.
	package := aCGOProject package.
	description := aCGOProject description copy.
	units := aCGOProject packageUnits collect: #asOngoingPackageVersion as: Set.
	assemblies := aCGOProject assemblies veryDeepCopy asSet.
	virtualPackages := aCGOProject virtualPackages veryDeepCopy asSet.
	externalProjects := aCGOProject externalProjects veryDeepCopy asSet.
]

{ #category : #initialization }
CGOOngoingProject >> initializeWithProjectName: aProjectName [
	self initializeWithPackageName: aProjectName andProject: nil.
	units := Set new.
	assemblies := Set new.
	virtualPackages := Set new.
	externalProjects := Set new.
	dependencies := OrderedCollection new
]

{ #category : #'compatibility - cargo solver' }
CGOOngoingProject >> isAssembly [
	"Needed so that Cargo solver can use a project as a standard package assembly"
	^ true
]

{ #category : #conflicts }
CGOOngoingProject >> isConflictingWith: aCGOResolvedDependency [ 
	
	^ (self name = aCGOResolvedDependency name)
		and: [ self ~= aCGOResolvedDependency resolution resolvedProjectVersion ]
]

{ #category : #testing }
CGOOngoingProject >> isEmpty [
	^ self packageUnitNames isEmpty 
		and: [self assemblies isEmpty 
			and: [self virtualPackages isEmpty] ]
]

{ #category : #testing }
CGOOngoingProject >> isInstalled [
	
	^ self isLoaded
]

{ #category : #testing }
CGOOngoingProject >> isLoaded [
	
	^ registry notNil
		and: [ registry isProjectInstalled: self ]
]

{ #category : #testing }
CGOOngoingProject >> isProject [
	^ true
]

{ #category : #resolution }
CGOOngoingProject >> isResolvedBy: aResolution [
	
	^ aResolution resolvesProject: self
]

{ #category : #'querying - installed' }
CGOOngoingProject >> isUpToDate [
	
	^ self allDependencies allSatisfy: [ :each | each isInstalled ]
]

{ #category : #'compatibility - package repository' }
CGOOngoingProject >> isVirtual [
	^ false
]

{ #category : #loading }
CGOOngoingProject >> load [
	
	self resolve load.
	
	CGOProjectLoaded announceOnProject: self. 
]

{ #category : #accessing }
CGOOngoingProject >> metacelloProjects [
	^ externalProjects 
		select: #isMetacelloProjectDependency
		thenCollect: [ :projectDependency | PBMetacelloProject fromProjectDependency: projectDependency ]
]

{ #category : #querying }
CGOOngoingProject >> modifiedPackageUnits [ 
	"check if either source code or metadata has been modified"
	self flag: 'TODO'.
	" for now, just return all packages part of the project"
	^ self packageUnits
		"select: #isDirty"
	"TO DO: isDirty should take into account the metadata state"
	"then return units objects"
]

{ #category : #accessing }
CGOOngoingProject >> name [
	^ self packageName
]

{ #category : #updating }
CGOOngoingProject >> newPackageAssembly: aCGOPackageAssemblyName [
	| assembly |
	
	assembly := CGOOngoingPackageAssembly 
		for: aCGOPackageAssemblyName asSymbol
		project: self.
	(assemblies includes: assembly)
		ifTrue: [ CGOPackageAlreadyRegistered signal ].		
	assemblies add: assembly.
	^ registry register: assembly
]

{ #category : #updating }
CGOOngoingProject >> newPackageUnit: aCGOPackageUnitName [
	| unit |
	unit := CGOOngoingPackageUnit
		named: aCGOPackageUnitName asSymbol
		project: self.
	(units includes: unit)
		ifTrue: [ CGOPackageAlreadyRegistered signal ].
	units add: unit.
	^ registry register: unit
]

{ #category : #updating }
CGOOngoingProject >> newVirtualPackage: aName [
	| virtual |
	
	virtual := CGOOngoingVirtualPackage 
		for: aName asSymbol 
		project: self.
	(virtualPackages includes: virtual)
		ifTrue: [ CGOPackageAlreadyRegistered signal ].
	virtualPackages add: virtual.
	^ registry register: virtual
]

{ #category : #accessing }
CGOOngoingProject >> packageUnitNames [
	^ units collect: #packageName
]

{ #category : #accessing }
CGOOngoingProject >> packageUnits [
	^ units
]

{ #category : #updating }
CGOOngoingProject >> packageUnits: aListOfPackageUnits [
	units := aListOfPackageUnits asSet.
	units do: [ :each | each project: self ]
]

{ #category : #accessing }
CGOOngoingProject >> packages [
	^ self packageUnits , self assemblies, self virtualPackages
]

{ #category : #printing }
CGOOngoingProject >> printOn: aStream [
	aStream 
		<< self class name
		<< '('
		<< self packageName
		<< ')'
]

{ #category : #problems }
CGOOngoingProject >> problemIcon [
	^ #error
]

{ #category : #problems }
CGOOngoingProject >> problemLongDescription [
	self isUpToDate ifFalse: [ ^ 'One or more dependencies are not up to date.
Please update the whole project or fix the dependencies.'].
	
	^ ''
]

{ #category : #problems }
CGOOngoingProject >> problemShortDescription [
	
	self isUpToDate ifFalse: [ ^ 'One or more dependencies are not up to date.' ].
	
	^ ''
]

{ #category : #accessing }
CGOOngoingProject >> project [
	^ self
]

{ #category : #'querying - installed' }
CGOOngoingProject >> providesPackage: aPackageDependency [ 

	^ false
]

{ #category : #'querying - installed' }
CGOOngoingProject >> providesProject: aProjectDependency [

	^ (self projectName = aProjectDependency name and: [ aProjectDependency satisfyConstraints: self version ])
			and: [ self defaultAssembly isInstalled ]
]

{ #category : #accessing }
CGOOngoingProject >> registry [
	^ registry
]

{ #category : #accessing }
CGOOngoingProject >> registry: aCGOPackageRegistry [ 
	registry := aCGOPackageRegistry
]

{ #category : #dependencies }
CGOOngoingProject >> removeDependency: aDependency [

	dependencies remove: aDependency.
	
	CGODependenciesChanged announceOnProject: self. 
]

{ #category : #removing }
CGOOngoingProject >> removePart: aCGOPackageVersion [
	registry unregister: aCGOPackageVersion.
	assemblies 
		remove: aCGOPackageVersion
		ifAbsent: [ 	units remove: aCGOPackageVersion ]
]

{ #category : #accessing }
CGOOngoingProject >> repository [
	^ repository
]

{ #category : #updating }
CGOOngoingProject >> repository: aCGOSourceRepository [ 
	repository := aCGOSourceRepository
]

{ #category : #private }
CGOOngoingProject >> resolve [
	
	^ registry newSolver solveProject: self
]

{ #category : #solving }
CGOOngoingProject >> resolveInSolver: aCGOSolver [ 
	
	"An ongoing project is already solved, we need the version in the image"
	^ self
]

{ #category : #saving }
CGOOngoingProject >> saveToSCM: commitMessage [ 
	self withRepositoryDo: [ :repo |
		repository := repo.
		[repo
			saveProject: self asVcsSerializedCargoProject
			withMessage: commitMessage]
			on: IceGitUsernameOrEmailNotFound 
			do: [ :error | error acceptError: (IceTipInteractiveErrorVisitor on: repository iceRepository) ] ].
	self flag: 'also implement push by asking to which remote we will push'
]

{ #category : #'system-interaction' }
CGOOngoingProject >> systemPackageOrganizer [
	
	^ systemPackageOrganizer ifNil: [ RPackageOrganizer default ]
]

{ #category : #'system-interaction' }
CGOOngoingProject >> systemPackageOrganizer: aPackageOrganizer [ 
	systemPackageOrganizer := aPackageOrganizer
]

{ #category : #accessing }
CGOOngoingProject >> virtualPackages [
	^ virtualPackages
]

{ #category : #updating }
CGOOngoingProject >> virtualPackages: aListOfVirtualPackages [ 
	virtualPackages := aListOfVirtualPackages
]

{ #category : #private }
CGOOngoingProject >> withRepositoryDo: aBlock [
	repository 
		ifNil: [ CGOGitRepositoryCreationPanel withNewRepositoryDo: aBlock ]
		ifNotNil: [ aBlock value: repository ]
]
