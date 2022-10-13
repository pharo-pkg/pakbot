Class {
	#name : #PBGitRepositoryCreatorTest,
	#superclass : #PBGitCreationTest,
	#category : #'Pakbot-Tests-Repository'
}

{ #category : #tests }
PBGitRepositoryCreatorTest >> testCanCreateLocalDirectory [
	| tempFolder |
	tempFolder := FileLocator temp	/
			('pharo-tests-PBGitRepositoryCreatorTest-', DateAndTime now asFileNameCompatibleString).
	PBGitRepository newLocalRepositoryIn: tempFolder.
	
	self assert: tempFolder exists.
	self assert: ( tempFolder / '.git' ) isDirectory.
	
	tempFolder ensureDeleteAll.
]

{ #category : #tests }
PBGitRepositoryCreatorTest >> testCanCreateRepositoryFromGitHubUrl [

	repository := PBGitRepositoryCreator new
		url: 'git@github.com:demarey/pharo-counter.git';
		create.

	self 	
		assert: repository class
		equals: PBGitRepository.
	self 
		assert: repository iceRepositoryCreator remote url
		equals: 'git@github.com:demarey/pharo-counter.git'
]

{ #category : #tests }
PBGitRepositoryCreatorTest >> testCanCreateRepositoryFromHttpUrl [

	repository := PBGitRepositoryCreator new
		url: 'https://github.com/demarey/pharo-counter.git';
		version: 'master';
		create.
		
	self 	
		assert: repository class 
		equals: PBGitRepository.
	self 
		assert: repository iceRepositoryCreator remote url
		equals: 'https://github.com/demarey/pharo-counter.git'
]

{ #category : #tests }
PBGitRepositoryCreatorTest >> testCanCreateRepositoryFromIcebergRepository [
	| iceRepository |
	iceRepository := IceRepositoryCreator new 
			addRemote: 'https://github.com/demarey/pharo-counter.git';
			location: self iceRepositoryLocation;
			subdirectory: '';
			createRepository. 
	repository := PBGitRepositoryCreator repositoryFromIceRepository: iceRepository.

	self 	
		assert: repository class
		equals: PBGitRepository.
	self 
		assert: repository repositoryUrl
		equals: 'https://github.com/demarey/pharo-counter.git'
]

{ #category : #tests }
PBGitRepositoryCreatorTest >> testCanCreateRepositoryFromSshUrl [

	repository := PBGitRepositoryCreator new
		url: 'ssh://git@github.com/demarey/pharo-counter.git';
		version: 'master';
		create.
		
	self 	
		assert: repository class 
		equals: PBGitRepository.
	self 
		assert: repository iceRepositoryCreator remote url
		equals: 'ssh://git@github.com/demarey/pharo-counter.git'
]

{ #category : #tests }
PBGitRepositoryCreatorTest >> testCanCreateRepositoryFromSshUrlWithNoProtocol [

	repository := PBGitRepositoryCreator repositoryFromUrl: 'git@github.com:demarey/pharo-counter.git'.
		
	self 	
		assert: repository class 
		equals: PBGitRepository.
	self 
		assert: repository repositoryUrl
		equals: 'git@github.com:demarey/pharo-counter.git'.
]
