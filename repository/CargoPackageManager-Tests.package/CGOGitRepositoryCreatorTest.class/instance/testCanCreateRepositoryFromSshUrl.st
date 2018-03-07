tests
testCanCreateRepositoryFromSshUrl
	| repository |

	repository := CGOGitRepositoryCreator new
		url: 'git+ssh://git@github.com/demarey/pharo-counter.git';
		version: 'master';
		create.
		
	self 	
		assert: repository class 
		equals: CGOGitRepository.
	self 
		assert: repository iceRepository origin url
		equals: 'git@github.com:demarey/pharo-counter.git'