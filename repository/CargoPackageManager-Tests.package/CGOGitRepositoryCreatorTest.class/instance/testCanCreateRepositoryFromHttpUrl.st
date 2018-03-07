tests
testCanCreateRepositoryFromHttpUrl
	| repository |

	repository := CGOGitRepositoryCreator new
		url: 'https://github.com/demarey/cargo.git';
		version: 'master';
		create.
		
	self 	
		assert: repository class 
		equals: CGOGitRepository.
	self 
		assert: repository iceRepository origin url
		equals: 'https://github.com/demarey/cargo.git'