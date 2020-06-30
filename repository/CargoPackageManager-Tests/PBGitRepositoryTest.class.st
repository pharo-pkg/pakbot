Class {
	#name : #PBGitRepositoryTest,
	#superclass : #PBGitCreationTest,
	#category : #'CargoPackageManager-Tests-SCM'
}

{ #category : #accessing }
PBGitRepositoryTest class >> defaultTimeLimit [ 
	^10 minutes
]

{ #category : #asserting }
PBGitRepositoryTest >> assertSrcPackageVersion: srcPackageVersion hasSameUrlAs: anotherPackageVersion [
	| repoUrl expectedUrl |
	repoUrl := ((srcPackageVersion instVarNamed: 'repository')
						instVarNamed: 'repositoryUrl').
	expectedUrl := ((anotherPackageVersion instVarNamed: 'repository') 
						instVarNamed: 'repositoryUrl').
	self assert: (repoUrl isKindOf: String).
	self assert: repoUrl	equals: expectedUrl
]

{ #category : #'tests - test data' }
PBGitRepositoryTest >> pakbotTestExampleMasterCloned [
	^ PBGitRepositoryCreator new
		githubUrl: 'https://github.com/pharo-pkg/PakbotTestExample.git';
		location: self iceRepositoryLocation;
		version: 'master';
		createAndClone
]

{ #category : #'tests - test data' }
PBGitRepositoryTest >> pharoCounterMaster [
	^ PBGitRepositoryCreator new
		githubUrl: 'https://github.com/demarey/pharo-counter.git';
		location: self iceRepositoryLocation;
		version: 'master';
		create
		
]

{ #category : #'tests - test data' }
PBGitRepositoryTest >> pharoCounterMasterCloned [
	^ self pharoCounterMaster 
		ensureCloned;
		yourself
]

{ #category : #tests }
PBGitRepositoryTest >> testCanBeDeserialized [
	| repositoryStonString deserializedRepository dict |
	repository := self pharoCounterMasterCloned.
	repositoryStonString := STON toStringPretty: repository.
	
	dict := STON fromString: repositoryStonString.
	deserializedRepository := PBSourceRepository fromDictionary: dict.
	
	self 
		assert: deserializedRepository repositoryUrl 
		equals: repository repositoryUrl.
		
	self 
		assert: deserializedRepository version 
		equals: repository version.
]

{ #category : #tests }
PBGitRepositoryTest >> testCanBeSerializedInSton [
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
PBGitRepositoryTest >> testCanDetectGitRepositoryCloned [
	| location |
	location := self iceRepositoryLocation.
	IceRepositoryCreator new 
			addRemote: 'https://github.com/demarey/pharo-counter';
			subdirectory: '';
			location: location;
			createRepository.
	repository := PBGitRepositoryCreator new
		githubUrl: 'git@github.com:demarey/pharo-counter.git';
		location: location;
		create.
	
	self assert: repository isCloned

]

{ #category : #tests }
PBGitRepositoryTest >> testCanDetectGitRepositoryNotClonedWhenMissingLocation [

	repository := self pharoCounterMaster.
	self deny: repository isCloned

]

{ #category : #tests }
PBGitRepositoryTest >> testCanEnsureRepositoryClonedAtBranchOriginHeadWhenRepositoryClonedInSameBranchAndDetachedHead [
	| iceRepository location |
	<expectedFailure>
	location := self iceRepositoryLocation.
	iceRepository := IceRepositoryCreator new 
			addRemote: 'https://github.com/demarey/pharo-counter';
			subdirectory: '';
			location: location;
			createRepository.
	(iceRepository lookupCommit: '749fcd4dd78387b6d46ed93dc5fda8a289d872f8') checkout.
	repository := PBGitRepositoryCreator new
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
PBGitRepositoryTest >> testCanEnsureRepositoryClonedWhenRepositoryNotYetCloned [

	repository := PBGitRepositoryCreator new
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
PBGitRepositoryTest >> testCanGetMCVersionWhenAOngoingPackageUnitProvided [
	| result |
	
	self flag:#todo.
	"This functionality uses old Iceberg API, should be migrated"
	self skip.	
	
	repository := self pharoCounterMasterCloned.
	result := repository mcVersionFor: (PBPackage for: 'Counter-Core').
	self assert: (result isKindOf: MCVersion)
]

{ #category : #tests }
PBGitRepositoryTest >> testCanGetMetadataFromGitRepository [
	| project |
	repository := self pharoCounterMasterCloned.
	project := repository project.
	
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
PBGitRepositoryTest >> testCanSavePackageAndItsMetadata [
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
PBGitRepositoryTest >> testErrorRaisedWhenRepositoryUrlIsWrong [
	self 
		should: [ IceRepositoryCreator new 
			addRemote: 'https://github.com/foo/bar.git';
			location: FileLocator temp / ('pharo-tests-' , DateAndTime now asFileNameCompatibleString);
			subdirectory: '';
			createRepository ]
		raise: IceError
]

{ #category : #tests }
PBGitRepositoryTest >> testGetPackageMetadataNotFoundErrorWhenMetadataFileAbsent [

	repository := PBGitRepositoryCreator new
		githubUrl: 'http://github.com/demarey/HotelApp.git';
		location: self iceRepositoryLocation;
		createAndClone.

	self should: [ repository project ] raise: PBProjectMetadataNotFound
]

{ #category : #tests }
PBGitRepositoryTest >> testGivenAGitRepositoryWhenNoPakbotMetadataPresentThenGetException [
	repository := self pakbotTestExampleMasterCloned.
	
	self 
		should: [ repository project ]
		raise: PBProjectMetadataNotFound 
]
