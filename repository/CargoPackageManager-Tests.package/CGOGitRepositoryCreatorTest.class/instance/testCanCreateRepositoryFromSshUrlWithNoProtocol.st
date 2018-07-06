tests
testCanCreateRepositoryFromSshUrlWithNoProtocol
	| repository |

	repository := CGOGitRepositoryCreator repositoryFromUrl: 'git@github.com:demarey/pharo-counter.git'.
		
	self 	
		assert: repository class 
		equals: CGOGitRepository.
	self 
		assert: repository repositoryUrl
		equals: 'git://git@github.com:demarey/pharo-counter.git'.