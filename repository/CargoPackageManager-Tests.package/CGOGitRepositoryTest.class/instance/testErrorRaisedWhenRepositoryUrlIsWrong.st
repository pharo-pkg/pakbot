tests
testErrorRaisedWhenRepositoryUrlIsWrong
	self 
		should: [ IceRepositoryCreator new 
			remote: (IceRemote url: 'https://github.com/foo/bar.git');
			location: FileLocator temp / ('pharo-tests-' , DateAndTime now asFileNameCompatibleString);
			subdirectory: '';
			createRepository ]
		raise: LGit_GIT_ERROR