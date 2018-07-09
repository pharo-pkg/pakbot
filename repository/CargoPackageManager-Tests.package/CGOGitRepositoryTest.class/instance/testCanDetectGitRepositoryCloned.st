tests
testCanDetectGitRepositoryCloned
	| location |
	location := self iceRepositoryLocation.
	IceRepositoryCreator new 
			addRemote: 'https://github.com/demarey/pharo-counter';
			subdirectory: '';
			location: location;
			createRepository.
	repository := CGOGitRepositoryCreator new
		githubUrl: 'github://demarey/pharo-counter:master';
		location: location;
		create.
	
	self assert: repository isCloned
