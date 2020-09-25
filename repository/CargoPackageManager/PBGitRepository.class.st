"
I represent a repository containing source code hosted on a Git server.
I hold a reference to an Iceberg repository to use it for some git operations.

- iceRepositoryCreator: In soma cases, you do not want to clone the git repository. It is not possible with an IceRepository always refering to a cloned git repository. To workaround that, we keep a reference to an IceRepositoryCreator that keeps all data needed to create the IceRepository. IceRepository will be nil until we need to call it, and so clone the repository. 
- iceRepository: a reference to the Iceberg repository to use to get data
- version : I can refer to a specific branch, tag or commit hash of the given git repository. If not, default version will be 'master.
- repositoryUrl: I also keep the origin url as it can be changed so that Iceberg accepts it. It is the same URL but with a different form (e.g. github://demarey/cargo:master vs git@gihub.com:demarey/cargo.git

	self example inspect
"
Class {
	#name : #PBGitRepository,
	#superclass : #PBSourceRepository,
	#instVars : [
		'iceRepositoryCreator',
		'iceRepository',
		'version',
		'subdirectory'
	],
	#category : #'CargoPackageManager-Loading'
}

{ #category : #example }
PBGitRepository class >> example [
	^ PBGitRepositoryCreator example
]

{ #category : #'instance creation' }
PBGitRepository class >> fromDictionary: aDictionary [
	^ PBGitRepositoryCreator new
		url: (aDictionary at: #repositoryUrl);
		version: (aDictionary at: #version ifAbsent: [ nil ]);
		create.
]

{ #category : #'instance creation' }
PBGitRepository class >> newLocalRepositoryIn: aFileReference [

	^ PBGitRepositoryCreator new
		url: 'file://', aFileReference fullName;
		location: aFileReference;
		createAndClone
]

{ #category : #'instance creation' }
PBGitRepository class >> repository: anIceLibgitRepository [ 
	
	^ self new
		repository: anIceLibgitRepository;
		yourself
]

{ #category : #accessing }
PBGitRepository class >> type [ 
	^ #git
]

{ #category : #'instance creation' }
PBGitRepository class >> url: anUrlOrString repository: anIceRepository [
	^ self url: anUrlOrString repository: anIceRepository version: nil
]

{ #category : #'instance creation' }
PBGitRepository class >> url: anUrlOrString repository: anIceRepository version: aCommitishString [
	^ self basicNew 
		initializeWithUrl: anUrlOrString repository: anIceRepository andVersion: aCommitishString;
		yourself
]

{ #category : #'instance creation' }
PBGitRepository class >> url: anUrlOrString repositoryCreator: anIceRepositoryCreator version: aCommitishString [
	^ self basicNew 
		initializeWithUrl: anUrlOrString repositoryCreator: anIceRepositoryCreator andVersion: aCommitishString;
		yourself
]

{ #category : #updating }
PBGitRepository >> addPackageNamed: aPackageName [
	^ self iceRepository workingCopy addPackageNamed: aPackageName
]

{ #category : #baselines }
PBGitRepository >> baselines [
	^ (self iceRepository workingCopy packages
		select: [ :each | each name beginsWith: 'BaselineOf' ])
		sorted: [ :a :b | a name < b name ].
]

{ #category : #accessing }
PBGitRepository >> codeDirectoryRelativePath [
	^ self subdirectory ifNotEmpty: [ :subdirectoryName | subdirectoryName , '/' ]
]

{ #category : #actions }
PBGitRepository >> createTag: aString [ 
	self iceRepository createTag: aString.
]

{ #category : #querying }
PBGitRepository >> currentCommitId [
	^ self iceRepository headCommit id
]

{ #category : #actions }
PBGitRepository >> ensureCloned [
	self isCloned
		ifFalse: [ iceRepository := iceRepositoryCreator createRepository.
					iceRepositoryCreator := nil. ].

	version isEmptyOrNil ifFalse: [ (iceRepository lookupCommit: version) checkout ].
		
	[ iceRepository register ]
		on: IceDuplicatedRepository 
		do: [ "repository already added to Iceberg. Ignore the warning and do not add it again." ].
		
	^ self
]

{ #category : #private }
PBGitRepository >> ensureIcePackageNamed: aPackageName [
	^ [ self iceRepository packageNamed: aPackageName ]
		on: NotFound 
		do: [ self iceRepository addPackageNamed: aPackageName ]
]

{ #category : #fetching }
PBGitRepository >> fetchHeadVersion [
	
	^ self fetchVersion: ''
]

{ #category : #fetching }
PBGitRepository >> fetchVersion: aString [
	| commitish project |
	commitish := aString
		ifEmpty: [ self headCommit ]
		ifNotEmpty: [ self iceRepository revparse: aString ].
	project := PBProjectVersion
		fromVcsStonString: (commitish fileSystem / self projectMetadataPath) contents.
	project repository: self.
	^ project
]

{ #category : #baselines }
PBGitRepository >> hasBaseline [
	^ self baselines size > 0
]

{ #category : #testing }
PBGitRepository >> hasTagNamed: aString [ 
	^ self iceRepository hasTagNamed: aString
]

{ #category : #accessing }
PBGitRepository >> headCommit [
	^ self iceRepository headCommit
]

{ #category : #accessing }
PBGitRepository >> iceRepository [
	^ iceRepository ifNil: [ self ensureCloned. iceRepository ]
]

{ #category : #querying }
PBGitRepository >> iceSavedPackageVersionFor: packageName [
	^ self iceRepository workingCopy versionFor: packageName
]

{ #category : #initialization }
PBGitRepository >> initialize [
	version := nil
]

{ #category : #initialization }
PBGitRepository >> initializeWithUrl: anUrlOrString repository: anIceRepository [
	self initialize.
	repositoryUrl := anUrlOrString.
	iceRepository := anIceRepository
]

{ #category : #initialization }
PBGitRepository >> initializeWithUrl: anUrlOrString repository: anIceRepository andVersion: aCommitishString [
	self initializeWithUrl: anUrlOrString repository: anIceRepository.
	version := aCommitishString
]

{ #category : #initialization }
PBGitRepository >> initializeWithUrl: anUrlOrString repositoryCreator: anIceRepositoryCreator [
	self initialize.
	repositoryUrl := anUrlOrString.
	iceRepositoryCreator := anIceRepositoryCreator
]

{ #category : #initialization }
PBGitRepository >> initializeWithUrl: anUrlOrString repositoryCreator: anIceRepositoryCreator andVersion: aCommitishString [
	self initializeWithUrl: anUrlOrString repositoryCreator: anIceRepositoryCreator.
	version := aCommitishString
]

{ #category : #private }
PBGitRepository >> isBranch: commitish [
	^ self iceRepository allBranches
		anySatisfy: [ :branch | branch name = commitish or: [ branch name endsWith: '/' , commitish ] ]
]

{ #category : #private }
PBGitRepository >> isCloned [
	self isIceRepositoryValid
		ifTrue: [ ^ true ].
	(self isRepositoryAlreadyClonedInDefaultLocation or: [ self isRepositoryAlreadyCloned ])
		ifTrue: [ iceRepository := iceRepositoryCreator addLocalRepository.
			^ true ].
	^ false
]

{ #category : #private }
PBGitRepository >> isIceRepositoryValid [
	^ iceRepository isNotNil	and: [ iceRepository isValid ]
]

{ #category : #private }
PBGitRepository >> isRepositoryAlreadyCloned [
	^ iceRepositoryCreator location isNotNil
		and: [ iceRepositoryCreator location exists
				and: [ iceRepositoryCreator location hasChildren ] ]
]

{ #category : #private }
PBGitRepository >> isRepositoryAlreadyClonedInDefaultLocation [
	^ iceRepositoryCreator location isNil
		and: [ iceRepositoryCreator defaultLocation exists
				and: [ iceRepositoryCreator defaultLocation hasChildren ] ]
]

{ #category : #loading }
PBGitRepository >> loadPackageNamed: aPackageName [
	self iceRepository workingCopy loadPackageNamed: aPackageName
]

{ #category : #querying }
PBGitRepository >> mcVersionFor: aPackageVersion [
	^ (self iceSavedPackageVersionFor: aPackageVersion packageName) mcVersion
]

{ #category : #private }
PBGitRepository >> metadataStringFor: aPackageUnit [
	^ (CGOPackageVersionWriterV1 toStringPretty: aPackageUnit asPackageVersion asSerializablePackageVersion) withInternetLineEndings

]

{ #category : #converting }
PBGitRepository >> pakbotProjectFromMetacelloBaseline [

	| baselinePackage baseline project |
	self hasBaseline ifFalse: [ ^ nil ].

	self flag: 'TODO: what to do if many baselines?'.
	baselinePackage := self baselines first load.
	baseline := self class environment at: baselinePackage name asSymbol.
	project := PBBaselineVisitor projectFor: baseline.
	project version: (SemanticVersion fromString: self headCommit id).
	^ project
]

{ #category : #fetching }
PBGitRepository >> project [
	| iceProject |
	iceProject := self iceRepository project.
	^ iceProject isUnborn
		ifTrue: [ PBProjectMetadataNotFound signal ]
		ifFalse: [ [ iceProject pakbotProject ] 
						on: PBProjectMetadataNotFound
						do: [ self pakbotProjectFromMetacelloBaseline ifNil: [ PBProjectMetadataNotFound signal ] ] ]
]

{ #category : #configuring }
PBGitRepository >> project: aPBIcebergProject [
	"Used to set the Pakbot Project when creating a new project."
	self iceRepository workingCopy basicSetProject: aPBIcebergProject.


]

{ #category : #accessing }
PBGitRepository >> projectMetadataPath [
	^ self codeDirectoryRelativePath , self projectMetadataFileName
]

{ #category : #fetching }
PBGitRepository >> projectMetadataStonString [
	
	^ (self iceRepository headCommit fileSystem / self projectMetadataPath) contents
]

{ #category : #accessing }
PBGitRepository >> repository: anIceLibgitRepository [ 
	
	iceRepository := anIceLibgitRepository
]

{ #category : #saving }
PBGitRepository >> savePackageUnit: packageUnit withMessage: commitMessage [
	| iceSavedPackage newMcVersion |
	iceSavedPackage := self ensureIcePackageNamed: packageUnit packageName.
	iceSavedPackage repository workingCopy ifNil: [ ^ nil "nothing to save" ].
	newMcVersion := self iceRepository 
		internalSavePackage: iceSavedPackage
		withMessage: commitMessage.
	self iceRepository 
		addFilesToIndex: { self iceRepository directoryForPackage: newMcVersion package }.
	^ newMcVersion
]

{ #category : #saving }
PBGitRepository >> savePackageUnits: packageUnits withMessage: commitMessage [
	packageUnits 
		do: [ :unit |
				self savePackageUnit: unit withMessage: commitMessage ]
]

{ #category : #querying }
PBGitRepository >> sourcePackageVersionClass [
	^ CGOGitHostedPackageVersion
]

{ #category : #serialization }
PBGitRepository >> stonOn: stonWriter [
	| url  dict |
	url := PBGitRepositoryCreator urlWithScheme: repositoryUrl.
	dict := OrderedDictionary 
		with: #type -> self class type
		with: 	#repositoryUrl -> url asString.
	version ifNotNil: [ dict at: #version put: version ].
	stonWriter writeMap: dict
]

{ #category : #accessing }
PBGitRepository >> subdirectory [
	^ self iceRepository subdirectory
]

{ #category : #accessing }
PBGitRepository >> version [
	^ version
]

{ #category : #accessing }
PBGitRepository >> version: aString [ 
	version := aString
]

{ #category : #notifying }
PBGitRepository >> versionLoaded: packageName [
	self flag: 'TODO: check if I need to notify Iceberg that a package has been loaded. See IceWorkingCopy>>loadPackagesNamed: aCollection fromCommit: aCommit'
	"iceRepository versionLoaded: 
		(self iceSavedPackageVersionFor: packageName)"
]
