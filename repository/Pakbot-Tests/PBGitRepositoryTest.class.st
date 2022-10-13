Class {
	#name : #PBGitRepositoryTest,
	#superclass : #PBGitCreationTest,
	#category : #'Pakbot-Tests-Repository'
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
		url: 'https://github.com/pharo-pkg/PakbotTestExample.git';
		location: self iceRepositoryLocation;
		version: 'master';
		createAndClone
]

{ #category : #'tests - test data' }
PBGitRepositoryTest >> pharoCounterMaster [
	^ PBGitRepositoryCreator new
		url: 'https://github.com/demarey/pharo-counter.git';
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
PBGitRepositoryTest >> testCanDetectBaselines [
	
	| baselines |
	repository := PBGitRepositoryCreator new
		url: 'https://github.com/pharo-pkg/PakbotTestExample.git';
		location: self iceRepositoryLocation;
		createAndClone.

	self assert: repository hasBaseline.
	
	baselines := repository baselines.
	self assert: baselines size equals: 1.
	self assert: baselines anyOne name equals: 'BaselineOfPakbotTestExample'

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
		url: 'git@github.com:demarey/pharo-counter.git';
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
		url: 'git@github.com:demarey/pharo-counter.git';
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
PBGitRepositoryTest >> testCanEnsureRepositoryClonedAtGivenBranch [
	| location |

	location := self iceRepositoryLocation.
	repository := PBGitRepositoryCreator new
		url: 'https://github.com/pharo-pkg/pharo-counter.git';
		location: location;
		version: 'metadataless';
		create.
	repository ensureCloned.
	
	self 
		assert: repository currentCommitId
		equals: '26c4d6e2b755891e7bacdb3e0df0c8df4e09c22e'.
]

{ #category : #tests }
PBGitRepositoryTest >> testCanEnsureRepositoryClonedWhenRepositoryNotYetCloned [

	repository := PBGitRepositoryCreator new
		url: 'http://github.com/demarey/pharo-counter.git';
		location: self iceRepositoryLocation;
		create.
		
	self deny: self iceRepositoryLocation exists.
	
	repository ensureCloned.
	
	self assert: repository iceRepository location exists.
	self
		assert: repository iceRepository branchName
		equals: 'master'
]

{ #category : #tests }
PBGitRepositoryTest >> testCanGetMCVersionWhenAPackageProvided [
	| result |

	repository := self pharoCounterMasterCloned.
	result := repository mcVersionFor: (PBPackage named: 'Counter-Core').
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
PBGitRepositoryTest >> testCanGetMetadataFromGitRepositoryWhenSourcesNotInRootFolder [
	| project |
	repository := PBGitRepositoryCreator new
		url: 'https://github.com/pharo-pkg/pharo-counter.git';
		location: self iceRepositoryLocation;
		version: 'sources-in-subfolder';
		createAndClone.
	self 
		assert: repository iceRepository head commit id 
		equals: '718628ac627124b691062a3220369934143ec616'.
		
	project := repository project.
	
	self 
		assert: project name
		equals: #PharoCounter.	
	self 
		assertCollection: (project packageUnits collect: #name)
		hasSameElements: #('Counter-Core' 'Counter-Tests').
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
		url: 'http://github.com/demarey/HotelApp.git';
		location: self iceRepositoryLocation;
		createAndClone.

	self should: [ repository project ] raise: PBProjectMetadataNotFound
]
