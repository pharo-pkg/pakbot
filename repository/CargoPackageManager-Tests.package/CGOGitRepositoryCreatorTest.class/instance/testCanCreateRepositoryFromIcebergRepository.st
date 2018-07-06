tests
testCanCreateRepositoryFromIcebergRepository
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