tests - test data
pharoCounterMaster
	^ CGOGitRepositoryCreator new
		githubUrl: 'github://demarey/pharo-counter:master';
		location: FileLocator temp / ('pharo-tests-' , DateAndTime now asFileNameCompatibleString);
		createAndClone