"
I represent a repository containing source code hosted on a Git server.
I hold a reference to an Iceberg repository to use it for some git operations.

- version : I can refer to a specific branch, tag or commit hash of the given git repository. If not, default version will be 'master.
- repositoryUrl: I also keep the origin url as it can be changed so that Iceberg accepts it. It is the same URL but with a different form (e.g. github://demarey/cargo:master vs git@gihub.com:demarey/cargo.git

	self example inspect
"
Class {
	#name : #CGOGitRepository,
	#superclass : #CGOSourceRepository,
	#instVars : [
		'iceRepository',
		'version',
		'subdirectory'
	],
	#category : #'CargoPackageManager-Loading'
}

{ #category : #example }
CGOGitRepository class >> example [
	^ CGOGitRepositoryCreator example
]

{ #category : #'instance creation' }
CGOGitRepository class >> url: anUrlOrString repository: anIceRepository [
	^ self url: anUrlOrString repository: anIceRepository version: nil
]

{ #category : #'instance creation' }
CGOGitRepository class >> url: anUrlOrString repository: anIceRepository version: aCommitishString [
	^ self basicNew 
		initializeWithUrl: anUrlOrString repository: anIceRepository andVersion: aCommitishString;
		yourself
]

{ #category : #accessing }
CGOGitRepository >> codeDirectoryRelativePath [
	^ self subdirectory ifNotEmpty: [ :subdirectoryName | subdirectoryName , '/' ]
]

{ #category : #querying }
CGOGitRepository >> currentCommitId [
	^ iceRepository headCommit id
]

{ #category : #actions }
CGOGitRepository >> ensureCloned [
	| commitish |
	self isCloned
		ifFalse: [ iceRepository := iceRepository createRepository ].

	commitish := version ifNil: [ 'master' ].
	(self isBranch: commitish)
		ifTrue: [ self syncBranchWithOrigin: commitish ]
		ifFalse: [ self syncToCommitish: commitish ].
		
	[ iceRepository register ]
		on: IceDuplicatedRepository 
		do: [ "reposiotry already added to Iceberg. Ignore the warning and do not add it again." ] 
]

{ #category : #private }
CGOGitRepository >> ensureIcePackageNamed: aPackageName [
	^ [ self iceRepository packageNamed: aPackageName ]
		on: NotFound 
		do: [ self iceRepository addPackageNamed: aPackageName ]
]

{ #category : #fetching }
CGOGitRepository >> fetchHeadVersion [
	
	^ self fetchVersion: ''
]

{ #category : #fetching }
CGOGitRepository >> fetchVersion: aString [
	
	| commitish project |
	self ensureCloned.
	
	commitish := aString
		ifEmpty: [ iceRepository headCommit ]
		ifNotEmpty: [ iceRepository revparse: aString ].


	project := PBProject fromStonString: (commitish fileSystem / self projectMetadataPath) contents.
	project repository: self.
	^ project
]

{ #category : #accessing }
CGOGitRepository >> iceRepository [
	^ iceRepository
]

{ #category : #querying }
CGOGitRepository >> iceSavedPackageVersionFor: packageName [
	^ iceRepository workingCopy versionFor: packageName
]

{ #category : #initialization }
CGOGitRepository >> initialize [
	version := nil
]

{ #category : #initialization }
CGOGitRepository >> initializeWithUrl: anUrlOrString repository: anIceRepository [
	self initialize.
	repositoryUrl := anUrlOrString.
	iceRepository := anIceRepository
]

{ #category : #initialization }
CGOGitRepository >> initializeWithUrl: anUrlOrString repository: anIceRepository andVersion: aCommitishString [
	self initializeWithUrl: anUrlOrString repository: anIceRepository.
	version := aCommitishString
]

{ #category : #private }
CGOGitRepository >> isBranch: commitish [
	^ iceRepository allBranches
		anySatisfy: [ :branch | branch name = commitish or: [ branch name endsWith: '/' , commitish ] ]
]

{ #category : #private }
CGOGitRepository >> isCloned [
	self isIceRepositoryValid
		ifTrue: [ ^ true ].
	(self isRepositoryAlreadyClonedInDefaultLocation or: [ self isRepositoryAlreadyCloned ])
		ifTrue: [ iceRepository := iceRepository addLocalRepository.
			^ true ].
	^ false
]

{ #category : #private }
CGOGitRepository >> isIceRepositoryValid [
	^ (iceRepository isKindOf: IceRepository)
		and: [ iceRepository isValid ]
]

{ #category : #private }
CGOGitRepository >> isRepositoryAlreadyCloned [
	^ iceRepository location isNotNil
		and: [ iceRepository location exists
				and: [ iceRepository location hasChildren ] ]
]

{ #category : #private }
CGOGitRepository >> isRepositoryAlreadyClonedInDefaultLocation [
	^ iceRepository location isNil
		and: [ iceRepository defaultLocation exists
				and: [ iceRepository defaultLocation hasChildren ] ]
]

{ #category : #loading }
CGOGitRepository >> loadPackageNamed: aPackageName [
	iceRepository workingCopy loadPackageNamed: aPackageName
]

{ #category : #querying }
CGOGitRepository >> mcVersionFor: aPackageVersion [
	self ensureCloned.
	^ (self iceSavedPackageVersionFor: aPackageVersion packageName) mcVersion
]

{ #category : #private }
CGOGitRepository >> metadataStringFor: aPackageUnit [
	^ (CGOPackageVersionWriterV1 toStringPretty: aPackageUnit asPackageVersion asSerializablePackageVersion) withInternetLineEndings

]

{ #category : #fetching }
CGOGitRepository >> project [
	| iceProject |
	iceProject := iceRepository project.
	^ iceProject isUnborn 
		ifTrue: [ PBProjectMetadataNotFound signal ]
		ifFalse: [ iceProject pakbotProject ]
]

{ #category : #accessing }
CGOGitRepository >> projectMetadataPath [
	^ self codeDirectoryRelativePath , self projectMetadataFileName
]

{ #category : #fetching }
CGOGitRepository >> projectMetadataStonString [
	self ensureCloned.
	
	^ (iceRepository headCommit fileSystem / self projectMetadataPath) contents
]

{ #category : #saving }
CGOGitRepository >> savePackageUnit: packageUnit withMessage: commitMessage [
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
CGOGitRepository >> savePackageUnits: packageUnits withMessage: commitMessage [
	packageUnits 
		do: [ :unit |
				self savePackageUnit: unit withMessage: commitMessage ]
]

{ #category : #saving }
CGOGitRepository >> saveProject: aVcsSerializedCargoProject withMessage: commitMessage [
	self saveProjectMetadataToIndex: aVcsSerializedCargoProject.
	^ self iceRepository commitWithMessage: commitMessage
	
]

{ #category : #saving }
CGOGitRepository >> saveProjectMetadataToIndex: serializableProject [
	^ self iceRepository 
		saveContent: (CGOPackageVersionWriterV1 toStringPretty: serializableProject) withInternetLineEndings
		inWorkingCopyFile: self projectMetadataPath
]

{ #category : #querying }
CGOGitRepository >> sourcePackageVersionClass [
	^ CGOGitHostedPackageVersion
]

{ #category : #serialization }
CGOGitRepository >> stonOn: stonWriter [
	| url |
	url := CGOGitRepositoryCreator urlWithScheme: repositoryUrl.
	stonWriter writeMap: (OrderedDictionary 
		with: #type -> #git
		with: 	#repositoryUrl -> url asString
		with: 	#version -> version)
]

{ #category : #accessing }
CGOGitRepository >> subdirectory [
	^ iceRepository subdirectory
]

{ #category : #private }
CGOGitRepository >> syncBranchWithOrigin: branchName [
	[ iceRepository branchName = branchName
		ifTrue: [ ^ self	"already in sync" ] ]
	on: IceNotInBranch
	do: [ "we are in DETACHED HEAD mode, let's chekout the branch" ].
	
	[ (iceRepository branchNamed: branchName) checkout ]
	on: IceBranchNotFound 
	do: [ (iceRepository remoteBranchNamed: 'origin/',branchName) checkout ].
	iceRepository fetch.
	iceRepository hasIncomingCommits
		ifTrue: [ iceRepository pull ]
]

{ #category : #private }
CGOGitRepository >> syncToCommitish: commitish [
	iceRepository headCommit = commitish
		ifFalse: [ (iceRepository lookupCommit: commitish) checkout ]
]

{ #category : #accessing }
CGOGitRepository >> version [
	^ version
]

{ #category : #accessing }
CGOGitRepository >> version: aString [ 
	version := aString
]

{ #category : #notifying }
CGOGitRepository >> versionLoaded: packageName [
	self flag: 'TODO: check if I need to notify Iceberg that a package has been loaded. See IceWorkingCopy>>loadPackagesNamed: aCollection fromCommit: aCommit'
	"iceRepository versionLoaded: 
		(self iceSavedPackageVersionFor: packageName)"
]
