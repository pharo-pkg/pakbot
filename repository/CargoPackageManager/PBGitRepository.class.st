"
I represent a repository containing source code hosted on a Git server.
I hold a reference to an Iceberg repository to use it for some git operations.

- version : I can refer to a specific branch, tag or commit hash of the given git repository. If not, default version will be 'master.
- repositoryUrl: I also keep the origin url as it can be changed so that Iceberg accepts it. It is the same URL but with a different form (e.g. github://demarey/cargo:master vs git@gihub.com:demarey/cargo.git

	self example inspect
"
Class {
	#name : #PBGitRepository,
	#superclass : #PBSourceRepository,
	#instVars : [
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

{ #category : #'instance-creation' }
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

{ #category : #updating }
PBGitRepository >> addPackageNamed: aPackageName [
	^ iceRepository workingCopy addPackageNamed: aPackageName
]

{ #category : #accessing }
PBGitRepository >> codeDirectoryRelativePath [
	^ self subdirectory ifNotEmpty: [ :subdirectoryName | subdirectoryName , '/' ]
]

{ #category : #querying }
PBGitRepository >> currentCommitId [
	^ iceRepository headCommit id
]

{ #category : #actions }
PBGitRepository >> ensureCloned [
	| commitish |
	self isCloned
		ifFalse: [ iceRepository := iceRepository createRepository ].


	version isEmptyOrNil ifFalse: [ (iceRepository lookupCommit: version) checkout ].
		
	[ iceRepository register ]
		on: IceDuplicatedRepository 
		do: [ "repository already added to Iceberg. Ignore the warning and do not add it again." ] 
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
	self ensureCloned.
	commitish := aString
		ifEmpty: [ self headCommit ]
		ifNotEmpty: [ iceRepository revparse: aString ].
	project := PBProject
		fromVcsStonString: (commitish fileSystem / self projectMetadataPath) contents.
	project repository: self.
	^ project
]

{ #category : #accessing }
PBGitRepository >> headCommit [
	^ iceRepository headCommit
]

{ #category : #accessing }
PBGitRepository >> iceRepository [
	^ iceRepository
]

{ #category : #querying }
PBGitRepository >> iceSavedPackageVersionFor: packageName [
	^ iceRepository workingCopy versionFor: packageName
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

{ #category : #private }
PBGitRepository >> isBranch: commitish [
	^ iceRepository allBranches
		anySatisfy: [ :branch | branch name = commitish or: [ branch name endsWith: '/' , commitish ] ]
]

{ #category : #private }
PBGitRepository >> isCloned [
	self isIceRepositoryValid
		ifTrue: [ ^ true ].
	(self isRepositoryAlreadyClonedInDefaultLocation or: [ self isRepositoryAlreadyCloned ])
		ifTrue: [ iceRepository := iceRepository addLocalRepository.
			^ true ].
	^ false
]

{ #category : #private }
PBGitRepository >> isIceRepositoryValid [
	^ (iceRepository isKindOf: IceRepository)
		and: [ iceRepository isValid ]
]

{ #category : #private }
PBGitRepository >> isRepositoryAlreadyCloned [
	^ iceRepository location isNotNil
		and: [ iceRepository location exists
				and: [ iceRepository location hasChildren ] ]
]

{ #category : #private }
PBGitRepository >> isRepositoryAlreadyClonedInDefaultLocation [
	^ iceRepository location isNil
		and: [ iceRepository defaultLocation exists
				and: [ iceRepository defaultLocation hasChildren ] ]
]

{ #category : #loading }
PBGitRepository >> loadPackageNamed: aPackageName [
	self ensureCloned.
	iceRepository workingCopy loadPackageNamed: aPackageName
]

{ #category : #querying }
PBGitRepository >> mcVersionFor: aPackageVersion [
	self ensureCloned.
	^ (self iceSavedPackageVersionFor: aPackageVersion packageName) mcVersion
]

{ #category : #private }
PBGitRepository >> metadataStringFor: aPackageUnit [
	^ (CGOPackageVersionWriterV1 toStringPretty: aPackageUnit asPackageVersion asSerializablePackageVersion) withInternetLineEndings

]

{ #category : #fetching }
PBGitRepository >> project [
	| iceProject |
	iceProject := iceRepository project.
	^ iceProject isUnborn
		ifTrue: [ PBProjectMetadataNotFound signal ]
		ifFalse: [ iceProject pakbotProject ]
]

{ #category : #configuring }
PBGitRepository >> project: aPBIcebergProject [
	"Used to set the Pakbot Project when creating a new project."
	iceRepository workingCopy basicSetProject: aPBIcebergProject.


]

{ #category : #accessing }
PBGitRepository >> projectMetadataPath [
	^ self codeDirectoryRelativePath , self projectMetadataFileName
]

{ #category : #fetching }
PBGitRepository >> projectMetadataStonString [
	self ensureCloned.
	
	^ (iceRepository headCommit fileSystem / self projectMetadataPath) contents
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
	^ iceRepository subdirectory
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
