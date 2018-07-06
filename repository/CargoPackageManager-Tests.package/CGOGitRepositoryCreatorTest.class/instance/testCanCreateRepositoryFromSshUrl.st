tests
testCanCreateRepositoryFromSshUrl
	| repository |

	repository := CGOGitRepositoryCreator new
		url: 'git://git@github.com/demarey/pharo-counter.git';
		version: 'master';
		create.
		
	self 	
		assert: repository class 
		equals: CGOGitRepository.
	self 
		assert: repository iceRepository remote url
		equals: 'git://git@github.com:demarey/pharo-counter.git'