Class {
	#name : #CGOGitRepositoryCreatorTest,
	#superclass : #CGOGitCreationTest,
	#category : 'CargoPackageManager-Tests-SCM'
}

{ #category : #tests }
CGOGitRepositoryCreatorTest >> testCanCreateRepositoryFromGitHubUrl [

	repository := CGOGitRepositoryCreator new
		githubUrl: 'github://demarey/pharo-counter:master';
		create.

	self 	
		assert: repository class
		equals: CGOGitRepository.
	self 
		assert: repository iceRepository remote url
		equals: 'git://git@github.com/demarey/pharo-counter.git'
]

{ #category : #tests }
CGOGitRepositoryCreatorTest >> testCanCreateRepositoryFromHttpUrl [

	repository := CGOGitRepositoryCreator new
		url: 'https://github.com/demarey/cargo.git';
		version: 'master';
		create.
		
	self 	
		assert: repository class 
		equals: CGOGitRepository.
	self 
		assert: repository iceRepository remote url
		equals: 'https://github.com/demarey/cargo.git'
]

{ #category : #tests }
CGOGitRepositoryCreatorTest >> testCanCreateRepositoryFromIcebergRepository [
	| iceRepository |
	iceRepository := IceRepositoryCreator new 
			addRemote: 'https://github.com/demarey/pharo-counter.git';
			location: self iceRepositoryLocation;
			subdirectory: '';
			createRepository. 
	repository := CGOGitRepositoryCreator repositoryFromIceRepository: iceRepository.

	self 	
		assert: repository class
		equals: CGOGitRepository.
	self 
		assert: repository repositoryUrl
		equals: 'https://github.com/demarey/pharo-counter.git'
]

{ #category : #tests }
CGOGitRepositoryCreatorTest >> testCanCreateRepositoryFromSshUrl [

	repository := CGOGitRepositoryCreator new
		url: 'git://git@github.com/demarey/pharo-counter.git';
		version: 'master';
		create.
		
	self 	
		assert: repository class 
		equals: CGOGitRepository.
	self 
		assert: repository iceRepository remote url
		equals: 'git://git@github.com/demarey/pharo-counter.git'
]

{ #category : #tests }
CGOGitRepositoryCreatorTest >> testCanCreateRepositoryFromSshUrlWithNoProtocol [

	repository := CGOGitRepositoryCreator repositoryFromUrl: 'git@github.com:demarey/pharo-counter.git'.
		
	self 	
		assert: repository class 
		equals: CGOGitRepository.
	self 
		assert: repository repositoryUrl
		equals: 'git://git@github.com/demarey/pharo-counter.git'.
]

{ #category : #tests }
CGOGitRepositoryCreatorTest >> testUrlValidationFailsIfDoesNotEndWithDotGit [
	self 
		should: [ CGOGitRepositoryCreator new
			url: 'git://git@github.com/demarey/pharo-counter';
			version: 'master';
			create ]
		raise: CGOGitRepositoryValidationError
]
