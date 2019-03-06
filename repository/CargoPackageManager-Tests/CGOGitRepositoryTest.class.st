Class {
	#name : #CGOGitRepositoryTest,
	#superclass : #CGOGitCreationTest,
	#category : 'CargoPackageManager-Tests-SCM'
}

{ #category : #accessing }
CGOGitRepositoryTest class >> defaultTimeLimit [ 
	^10 minutes
]

{ #category : #asserting }
CGOGitRepositoryTest >> assertSrcPackageVersion: srcPackageVersion hasSameUrlAs: anotherPackageVersion [
	| repoUrl expectedUrl |
	repoUrl := ((srcPackageVersion instVarNamed: 'repository')
						instVarNamed: 'repositoryUrl').
	expectedUrl := ((anotherPackageVersion instVarNamed: 'repository') 
						instVarNamed: 'repositoryUrl').
	self assert: (repoUrl isKindOf: String).
	self assert: repoUrl	equals: expectedUrl
]

{ #category : #'tests - test data' }
CGOGitRepositoryTest >> cargoMinimalB9ee [
	^ CGOGitHostedPackageVersionEnforcingProtocol
		repositoryUrl: 'git@github.com:demarey/cargo.git'
		subdirectory: 'repository'
		packageName: 'CargoPackageManager-Minimal'
		commitish: 'b9ee048f40e500198120aedf8db60266caa9ece9' 
]

{ #category : #'tests - test data' }
CGOGitRepositoryTest >> cargoMinimalB9eeHttpsUrl [
	^ CGOGitHostedPackageVersion
		repositoryUrl: 'https://github.com/demarey/cargo.git'
		subdirectory: 'repository'
		packageName: 'CargoPackageManager-Minimal'
		commitish: 'b9ee048f40e500198120aedf8db60266caa9ece9'
]

{ #category : #'tests - test data' }
CGOGitRepositoryTest >> pharoCounterMaster [
	^ CGOGitRepositoryCreator new
		githubUrl: 'https://github.com/demarey/pharo-counter.git';
		location: self iceRepositoryLocation;
		version: 'master';
		create
		
]

{ #category : #'tests - test data' }
CGOGitRepositoryTest >> pharoCounterMasterCloned [
	^ self pharoCounterMaster 
		ensureCloned;
		yourself
]

{ #category : #'tests - test data' }
CGOGitRepositoryTest >> pharoCounterTestsOriginRepo [
	^ CGOGitHostedPackageVersion
		repositoryUrl: 'git@github.com:demarey/pharo-counter.git'
		subdirectory: ''
		packageName: 'Counter-Tests'
		commitish: 'master'
]

{ #category : #'tests - test data' }
CGOGitRepositoryTest >> stonCargoMinimalB9ee [
	^ 'CGOGitHostedPackageVersion{#repository:CGOGitRepository{#repositoryUrl:''git@github.com:demarey/cargo.git'',#subdirectory:''repository''},#packageName:#CargoPackageManager-Minimal,#commitish:''b9ee048f40e500198120aedf8db60266caa9ece9''}'
]

{ #category : #'tests - test data' }
CGOGitRepositoryTest >> stonCargoMinimalB9eeHttpsUrl [
	^ 'CGOGitHostedPackageVersion{#repository:CGOGitRepository{#repositoryUrl:''https://github.com/demarey/cargo.git'',#subdirectory:''repository''},#packageName:#CargoPackageManager-Minimal,#commitish:''b9ee048f40e500198120aedf8db60266caa9ece9''}'
]

{ #category : #tests }
CGOGitRepositoryTest >> testCanBeDeserialized [
	| repositoryStonString deserializedRepository dict |
	repository := self pharoCounterMasterCloned.
	repositoryStonString := STON toStringPretty: repository.
	
	dict := STON fromString: repositoryStonString.
	deserializedRepository := CGOSourceRepository fromDictionary: dict.
	
	self 
		assert: deserializedRepository repositoryUrl 
		equals: repository repositoryUrl.
		
	self 
		assert: deserializedRepository version 
		equals: repository version.
]

{ #category : #tests }
CGOGitRepositoryTest >> testCanBeSerializedInSton [
	| repositoryStonString |
	repository := self pharoCounterMasterCloned.
	repositoryStonString := STON toStringPretty: repository.
	
	self 
		assert: repositoryStonString
		equals: '{
	#type : #git,
	#repositoryUrl : ''https://github.com/demarey/pharo-counter.git'',
	#version : ''master''
}'
]

{ #category : #tests }
CGOGitRepositoryTest >> testCanDetectGitRepositoryCloned [
	| location |
	location := self iceRepositoryLocation.
	IceRepositoryCreator new 
			addRemote: 'https://github.com/demarey/pharo-counter';
			subdirectory: '';
			location: location;
			createRepository.
	repository := CGOGitRepositoryCreator new
		githubUrl: 'git@github.com:demarey/pharo-counter.git';
		location: location;
		create.
	
	self assert: repository isCloned

]

{ #category : #tests }
CGOGitRepositoryTest >> testCanDetectGitRepositoryNotClonedWhenMissingLocation [

	repository := self pharoCounterMaster.
	self deny: repository isCloned

]

{ #category : #tests }
CGOGitRepositoryTest >> testCanEnsureRepositoryClonedAtBranchOriginHeadWhenRepositoryClonedInSameBranchAndDetachedHead [
	| iceRepository location |
	<expectedFailure>
	location := self iceRepositoryLocation.
	iceRepository := IceRepositoryCreator new 
			addRemote: 'https://github.com/demarey/pharo-counter';
			subdirectory: '';
			location: location;
			createRepository.
	(iceRepository lookupCommit: '749fcd4dd78387b6d46ed93dc5fda8a289d872f8') checkout.
	repository := CGOGitRepositoryCreator new
		githubUrl: 'git@github.com:demarey/pharo-counter.git';
		location: location;
		create.
	
	self 
		assert: iceRepository headCommit id
		equals: '749fcd4dd78387b6d46ed93dc5fda8a289d872f8'.
	
	repository ensureCloned.
	
	self 
		assert: repository currentCommitId
		equals: 'cfa408b472bc054a3a6e5deca7fde122d81ca125'.
]

{ #category : #tests }
CGOGitRepositoryTest >> testCanEnsureRepositoryClonedWhenRepositoryNotYetCloned [

	repository := CGOGitRepositoryCreator new
		githubUrl: 'http://github.com/demarey/pharo-counter.git';
		location: self iceRepositoryLocation;
		create.
		
	self deny: repository iceRepository location exists.
	
	repository ensureCloned.
	
	self assert: repository iceRepository location exists.
	self
		assert: repository iceRepository branchName
		equals: 'master'
]

{ #category : #tests }
CGOGitRepositoryTest >> testCanGetMCVersionWhenAOngoingPackageUnitProvided [
	| result |
	
	self flag:#todo.
	"This functionality uses old Iceberg API, should be migrated"
	self skip.	
	
	repository := self pharoCounterMasterCloned.
	result := repository mcVersionFor: (PBPackage for: 'Counter-Core').
	self assert: (result isKindOf: MCVersion)
]

{ #category : #tests }
CGOGitRepositoryTest >> testCanGetMetadataFromGitRepository [
	| project |
	repository := self pharoCounterMasterCloned.
	project := PBProject fromVcsStonString: repository projectMetadataStonString.
	
	self 
		assert: project name
		equals: #Counter.
	self 
		assert: project packageUnits anyOne class 
		equals: PBPackage.
	
	self 
		assertCollection: (project packageUnits collect: #name)
		hasSameElements: #('Counter-Core' 'Counter-Tests').
		
	self 
		assert: (project packageUnits detect: [ :each | each name = #'Counter-Core']) dependencies isEmpty.
	self 
		assert: (project packageUnits detect: [ :each | each name = #'Counter-Tests']) dependencies size
		equals: 1.
	self 
		assert: project assemblies isEmpty.

]

{ #category : #tests }
CGOGitRepositoryTest >> testCanSavePackageAndItsMetadata [
	| mcVersion message |
	
	self flag:#todo.
	"This functionality uses old Iceberg API, should be migrated"
	self skip.
	
	repository := self pharoCounterMasterCloned.
	message := 'commit from test #testCanSavePackageAndItsMetadata'.
	mcVersion := repository 
		savePackageUnit: (PBPackage for: 'Counter-Core') withMessage: message.
	self 
		assert: mcVersion info message
		equals: message
]

{ #category : #tests }
CGOGitRepositoryTest >> testErrorRaisedWhenRepositoryUrlIsWrong [
	self 
		should: [ IceRepositoryCreator new 
			addRemote: 'https://github.com/foo/bar.git';
			location: FileLocator temp / ('pharo-tests-' , DateAndTime now asFileNameCompatibleString);
			subdirectory: '';
			createRepository ]
		raise: IceGenericError
]

{ #category : #tests }
CGOGitRepositoryTest >> testGetPackageMetadataNotFoundErrorWhenMetadataFileAbsent [

	repository := CGOGitRepositoryCreator new
		githubUrl: 'http://github.com/demarey/HotelApp.git';
		location: self iceRepositoryLocation;
		createAndClone.

	self should: [ repository project ] raise: PBProjectMetadataNotFound
]
