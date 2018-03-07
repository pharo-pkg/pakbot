tests
testCanCreateRepositoryFromGitHubUrl
	| repository |

	repository := CGOGitRepositoryCreator new
		githubUrl: 'github://demarey/pharo-counter:master';
		create.

	self 	
		assert: repository class
		equals: CGOGitRepository.
	self 
		assert: repository iceRepository origin url
		equals: 'git@github.com:demarey/pharo-counter.git'