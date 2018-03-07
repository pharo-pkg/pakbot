tests
testCanCreateRepositoryFromIcebergRepository
	| iceRepository repository |
	iceRepository := IceRepositoryCreator new 
			remote: (IceRemote url: 'https://github.com/demarey/pharo-counter.git');
			location: FileLocator temp / ('pharo-tests-' , DateAndTime now asFileNameCompatibleString);
			subdirectory: '';
			createRepository. 
	repository := CGOGitRepositoryCreator repositoryFromIceRepository: iceRepository.

	self 	
		assert: repository class
		equals: CGOGitRepository.
	self 
		assert: repository repositoryUrl
		equals: 'https://github.com/demarey/pharo-counter.git'