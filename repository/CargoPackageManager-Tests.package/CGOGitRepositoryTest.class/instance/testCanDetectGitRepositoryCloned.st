tests
testCanDetectGitRepositoryCloned
	| location |
	location := self gitRepoUniqueLocation.
	IceRepositoryCreator new 
			addRemote: 'git@github.com:demarey/pharo-counter';
			subdirectory: '';
			location: location;
			createRepository.
	repository := CGOGitRepositoryCreator new
		githubUrl: 'github://demarey/pharo-counter:master';
		location: location;
		create.
	
	self assert: repository isCloned
