Class {
	#name : #PBGitRepositoryCreatorTest,
	#superclass : #PBGitCreationTest,
	#category : #'CargoPackageManager-Tests-SCM'
}

{ #category : #tests }
PBGitRepositoryCreatorTest >> testCanCreateRepositoryFromGitHubUrl [

	repository := PBGitRepositoryCreator new
		githubUrl: 'git@github.com:demarey/pharo-counter.git';
		create.

	self 	
		assert: repository class
		equals: PBGitRepository.
	self 
		assert: repository iceRepository remote url
		equals: 'git@github.com:demarey/pharo-counter.git'
]

{ #category : #tests }
PBGitRepositoryCreatorTest >> testCanCreateRepositoryFromHttpUrl [

	repository := PBGitRepositoryCreator new
		url: 'https://github.com/demarey/cargo.git';
		version: 'master';
		create.
		
	self 	
		assert: repository class 
		equals: PBGitRepository.
	self 
		assert: repository iceRepository remote url
		equals: 'https://github.com/demarey/cargo.git'
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
		url: 'git://git@github.com/demarey/pharo-counter.git';
		version: 'master';
		create.
		
	self 	
		assert: repository class 
		equals: PBGitRepository.
	self 
		assert: repository iceRepository remote url
		equals: 'git://git@github.com/demarey/pharo-counter.git'
]

{ #category : #tests }
PBGitRepositoryCreatorTest >> testCanCreateRepositoryFromSshUrlWithNoProtocol [

	repository := PBGitRepositoryCreator repositoryFromUrl: 'git@github.com:demarey/pharo-counter.git'.
		
	self 	
		assert: repository class 
		equals: PBGitRepository.
	self 
		assert: repository repositoryUrl
		equals: 'git://git@github.com/demarey/pharo-counter.git'.
]
