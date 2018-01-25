tests - test data
pharoCounterMaster
	| iceRepository |
	iceRepository := IceRepositoryCreator new 
			remote: (IceRemote url: 'https://github.com/demarey/pharo-counter.git');
			location: FileLocator temp / ('pharo-tests-' , DateAndTime now asFileNameCompatibleString);
			subdirectory: '';
			createRepository.
	^ CGOGitRepository repository: iceRepository