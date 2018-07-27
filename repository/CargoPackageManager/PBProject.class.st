"
I represent a software project. I store basic metadata for the project.
A Cargo project holds the list of assemblies (convenient and logical group of project packages) and virtual packages as well as the names of the package units (representing source code package) part of this project.
"
Class {
	#name : #PBProject,
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
PBProject class >> example [
	^ (self named: #'MyProject')
		description: 'A simple project used for illustration.';
		packages: { PBPackage example };
		yourself
]

{ #category : #'instance creation' }
PBProject class >> for: aProjectName [
	
	self deprecated: 'Please use #named: instead'
		transformWith: '`@receiver for: `@statements1' 
						-> '`@receiver named: `@statements1'.
	
	^ self named: aProjectName
]

{ #category : #'instance creation' }
PBProject class >> fromRepository: aCGOSourceRepository [
	| ongoing |
	ongoing := self fromStonString: aCGOSourceRepository projectMetadataStonString.
	ongoing repository: aCGOSourceRepository.
	^ ongoing
]

{ #category : #'instance creation' }
PBProject class >> fromVcsSerializedProject: aVcsSerializedProject [
	| ongoing |
	ongoing := self basicNew
		registry: CGOPackageRegistry default;
		yourself.
	aVcsSerializedProject flushIn: ongoing.
	^ ongoing
]

{ #category : #'instance creation' }
PBProject class >> named: aProjectName [
	^ self basicNew
		initializeWithProjectName: aProjectName;
		yourself 
]

{ #category : #'instance creation' }
PBProject class >> new [

	self error: 'Please use #named:'
]

{ #category : #comparing }
PBProject >> = other [
	self species == other species ifFalse: [ ^ false ].
	^ self name = other name
]

{ #category : #updating }
PBProject >> addAssemblyNamed: aName [
	| assembly |
	
	assembly := PBAssembly 
		named: aName asSymbol
		project: self.
	(assemblies includes: assembly)
		ifTrue: [ CGOPackageAlreadyRegistered signal ].		
	assemblies add: assembly.
	^ registry register: assembly
]

{ #category : #dependencies }
PBProject >> addDependency: aDependency [

	dependencies add: aDependency.
	aDependency project: self.
	
	self announceChangeInDependencies
]

{ #category : #updating }
PBProject >> addExternalCargoProject: aCGOProjectDependencyDeclaration [ 
	externalProjects add: aCGOProjectDependencyDeclaration
]

{ #category : #dependencies }
PBProject >> allDependencies [
	^ dependencies , (packages flatCollect: #allDependencies) asOrderedCollection.
]

{ #category : #dependencies }
PBProject >> announceChangeInDependencies [
	CGODependenciesChanged announceOnProject: self
]

{ #category : #converting }
PBProject >> asCargoProject [
	^ CGOProject fromOngoing: self
]

{ #category : #converting }
PBProject >> asOngoingPackage [
	^ self
]

{ #category : #converting }
PBProject >> asSerializedCargoProject [
	"VCS version of the project metadata (i.e. minimum metadata)"
	^ CGOVcsSerializedProject from: self
]

{ #category : #converting }
PBProject >> asVcsSerializedCargoProject [
	"VCS version of the project metadata (i.e. minimum metadata)"
	^ CGOVcsSerializedProject from: self
]

{ #category : #accessing }
PBProject >> assemblies [
	^ assemblies
]

{ #category : #updating }
PBProject >> assemblies: aListOfPackageAssemblies [
	assemblies := aListOfPackageAssemblies
]

{ #category : #accessing }
PBProject >> authors [
	self flag: 'TODO'.
	" Use libigt to get the result of this command?
		git log 5c3843fd626b6ce88b74302ba9d2af6bc93904a9 --format='%aN' --reverse
	"
	^ #()
]

{ #category : #'private-loading' }
PBProject >> basicLoad [
	registry registerProject: self.
	self packageUnits do: #basicLoad.
	CGOProjectLoaded announceOnProject: self. 
]

{ #category : #accessing }
PBProject >> cargoProjectDependencies [
	^ externalProjects reject: #isMetacelloProjectDependency
]

{ #category : #accessing }
PBProject >> children [
	^ self packageUnits , self assemblies, self virtualPackages
]

{ #category : #adding }
PBProject >> createPackageNamed: aString [ 
	
	"We delegate to the system the creation of a package first.
	This will fail if a package with that name already exists.
	If that succeeds, we register that new package in this project."
	[ self systemPackageOrganizer createPackageNamed: aString ]
		on: RPackageConflictError
		do: [ :error | CGOSystemPackageAlreadyDefined signal: aString ].

	^ self importPackageNamed: aString.
]

{ #category : #accessing }
PBProject >> defaultAssembly [

	^ (PBAssembly named: #default inProject: self)
		parts: packages copy;
		yourself
]

{ #category : #dependencies }
PBProject >> dependencies [
	
	^ dependencies
]

{ #category : #dependencies }
PBProject >> dependencies: aDependencyList [ 
	dependencies := aDependencyList
]

{ #category : #accessing }
PBProject >> externalProjects [
	^ externalProjects
]

{ #category : #updating }
PBProject >> externalProjects: aDictionnaryOfCGOProjectDependencyDeclaration [  
	externalProjects := aDictionnaryOfCGOProjectDependencyDeclaration
]

{ #category : #accessing }
PBProject >> fullyQualifiedName [

	 ^ self name
]

{ #category : #testing }
PBProject >> hasPackageNamed: aString [ 
	
	^ packages anySatisfy: [ :any | any name = aString ]
]

{ #category : #testing }
PBProject >> hasProblems [
	^ self isUpToDate not
]

{ #category : #testing }
PBProject >> hasRepository [
	
	^ repository isValidRepository
]

{ #category : #comparing }
PBProject >> hash [

	^ self name hash
]

{ #category : #adding }
PBProject >> importPackageNamed: aString [
	^ registry register: (self newNotLoadedPackage: aString)
]

{ #category : #initialization }
PBProject >> initialize [
	super initialize.
	repository := PBNoRepository new.
	version := '0.0.0-N/A' asSemanticVersion.
	description := ''.
]

{ #category : #initialization }
PBProject >> initializeFromProject: aCGOProject [
	self initialize.
	description := aCGOProject description copy.
	packages := aCGOProject packageUnits collect: #asOngoingPackageVersion as: OrderedCollection.
	assemblies := aCGOProject assemblies veryDeepCopy asSet.
	virtualPackages := aCGOProject virtualPackages veryDeepCopy asSet.
	externalProjects := aCGOProject externalProjects veryDeepCopy asSet.
]

{ #category : #initialization }
PBProject >> initializeWithProjectName: aProjectName [
	"The packages is an OrderedCollection, the unicity of the elements is guarantee in other part of the code."
	
	self initialize.
	name := aProjectName.
	packages := OrderedCollection new.
	assemblies := Set new.
	virtualPackages := Set new.
	externalProjects := Set new.

]

{ #category : #accessing }
PBProject >> installedSystemPackages [
	
	^ self packages select: [ :each | each isInstalled ] thenCollect: [ :each | each systemPackage ]
]

{ #category : #'compatibility - cargo solver' }
PBProject >> isAssembly [
	"Needed so that Cargo solver can use a project as a standard package assembly"
	^ true
]

{ #category : #conflicts }
PBProject >> isConflictingWith: aCGOResolvedDependency [ 
	
	^ (self name = aCGOResolvedDependency name)
		and: [ self ~= aCGOResolvedDependency resolution resolvedProjectVersion ]
]

{ #category : #testing }
PBProject >> isEmpty [
	^ self packageNames isEmpty 
		and: [self assemblies isEmpty 
			and: [self virtualPackages isEmpty] ]
]

{ #category : #testing }
PBProject >> isInstalled [
	
	^ self isLoaded
]

{ #category : #testing }
PBProject >> isLoaded [
	
	^ registry notNil
		and: [ registry isProjectInstalled: self ]
]

{ #category : #testing }
PBProject >> isProject [
	^ true
]

{ #category : #resolution }
PBProject >> isResolvedBy: aResolution [
	
	^ aResolution resolvesProject: self
]

{ #category : #'querying - installed' }
PBProject >> isUpToDate [
	
	^ self allDependencies allSatisfy: [ :each | each isInstalled ]
]

{ #category : #'compatibility - package repository' }
PBProject >> isVirtual [
	^ false
]

{ #category : #loading }
PBProject >> load [
	
	self resolve load.
	
	CGOProjectLoaded announceOnProject: self. 
]

{ #category : #accessing }
PBProject >> metacelloProjects [
	^ externalProjects 
		select: #isMetacelloProjectDependency
		thenCollect: [ :projectDependency | PBMetacelloProject fromProjectDependency: projectDependency ]
]

{ #category : #adding }
PBProject >> newNotLoadedPackage: aString [ 
	| unit |

	unit := PBPackage named: aString asSymbol project: self.

	(packages includes: unit)
		ifTrue: [ CGOPackageAlreadyRegistered signal ].

	packages add: unit.
	
	CGOProjectPartsChanged announceOnProject: self.
	
	^ unit
]

{ #category : #updating }
PBProject >> newVirtualPackage: aName [
	| virtual |
	
	virtual := PBVirtualPackage 
		for: aName asSymbol 
		project: self.
	(virtualPackages includes: virtual)
		ifTrue: [ CGOPackageAlreadyRegistered signal ].
	virtualPackages add: virtual.
	^ registry register: virtual
]

{ #category : #accessing }
PBProject >> packageNames [
	^ packages collect: #name
]

{ #category : #accessing }
PBProject >> packageUnits [
	^ packages
]

{ #category : #updating }
PBProject >> packages [

	^ packages
]

{ #category : #updating }
PBProject >> packages: aListOfPackageUnits [
	packages := aListOfPackageUnits asSet.
	packages do: [ :each | each project: self ]
]

{ #category : #printing }
PBProject >> printOn: aStream [
	aStream 
		<< self class name
		<< '('
		<< self name
		<< ')'
]

{ #category : #problems }
PBProject >> problemIcon [
	^ #error
]

{ #category : #problems }
PBProject >> problemLongDescription [
	self isUpToDate ifFalse: [ ^ 'One or more dependencies are not up to date.
Please update the whole project or fix the dependencies.'].
	
	^ ''
]

{ #category : #problems }
PBProject >> problemShortDescription [
	
	self isUpToDate ifFalse: [ ^ 'One or more dependencies are not up to date.' ].
	
	^ ''
]

{ #category : #accessing }
PBProject >> project [
	^ self
]

{ #category : #publishing }
PBProject >> publish [

	Cargo defaultPackageRepository savePackageVersion: self
]

{ #category : #accessing }
PBProject >> registry [
	^ registry
]

{ #category : #accessing }
PBProject >> registry: aCGOPackageRegistry [ 
	registry := aCGOPackageRegistry
]

{ #category : #assemblies }
PBProject >> removeAssembly: aPBAssembly [ 
	
	assemblies remove: aPBAssembly
]

{ #category : #dependencies }
PBProject >> removeDependency: aDependency [
	dependencies remove: aDependency.
	self announceChangeInDependencies
]

{ #category : #packages }
PBProject >> removePackage: aPBPackage [ 
	
	packages remove: aPBPackage.
	assemblies do: [ :each | each removePackage: aPBPackage ifAbsent: [ "Nothing" ] ].
	
	CGOProjectPartsChanged announceOnProject: self.
]

{ #category : #removing }
PBProject >> removePart: aCGOPackageVersion [
	registry unregister: aCGOPackageVersion.

	assemblies 
		remove: aCGOPackageVersion
		ifAbsent: [ 	packages remove: aCGOPackageVersion ]
]

{ #category : #accessing }
PBProject >> repository [
	^ repository
]

{ #category : #updating }
PBProject >> repository: aCGOSourceRepository [ 
	repository := aCGOSourceRepository
]

{ #category : #loading }
PBProject >> resolve [
	
	^ registry newSolver solveProject: self
]

{ #category : #solving }
PBProject >> resolveInSolver: aCGOSolver [ 
	
	"An ongoing project is already solved, we need the version in the image"
	^ self
]

{ #category : #'system-interaction' }
PBProject >> systemPackageOrganizer [
	
	^ registry systemPackageOrganizer
]

{ #category : #accessing }
PBProject >> version [
	^ version
]

{ #category : #accessing }
PBProject >> version: anObject [
	version := anObject
]

{ #category : #accessing }
PBProject >> virtualPackages [
	^ virtualPackages
]

{ #category : #updating }
PBProject >> virtualPackages: aListOfVirtualPackages [ 
	virtualPackages := aListOfVirtualPackages
]

{ #category : #private }
PBProject >> withRepositoryDo: aBlock [
	repository 
		ifNil: [ CGOGitRepositoryCreationPanel withNewRepositoryDo: aBlock ]
		ifNotNil: [ aBlock value: repository ]
]
