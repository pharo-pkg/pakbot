tests
testErrorRaisedWhenRepositoryUrlIsWrong
	| repo |
	repo := IceRepositoryCreator new 
			remote: (IceRemote url: 'https://github.com/foo/bar.git');
			location: FileLocator temp / ('pharo-tests-' , DateAndTime now asFileNameCompatibleString);
			subdirectory: '';
			createRepository.
	repo := CGOGitRepository repository: repo.
	
	self 
		should: [ repo mcVersion ]
		raise: LGit_GIT_ERROR ", MCFileTreeGitError (gitfiletree not included in the default distribution)"