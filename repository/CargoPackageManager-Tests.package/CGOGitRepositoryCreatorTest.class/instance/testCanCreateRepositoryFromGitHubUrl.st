tests
testCanCreateRepositoryFromGitHubUrl

	repository := CGOGitRepositoryCreator new
		githubUrl: 'github://demarey/pharo-counter:master';
		create.

	self 	
		assert: repository class
		equals: CGOGitRepository.
	self 
		assert: repository iceRepository remote url
		equals: 'git://git@github.com/demarey/pharo-counter.git'