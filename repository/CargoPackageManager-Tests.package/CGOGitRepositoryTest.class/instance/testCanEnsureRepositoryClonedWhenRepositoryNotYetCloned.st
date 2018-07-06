tests
testCanEnsureRepositoryClonedWhenRepositoryNotYetCloned

	repository := CGOGitRepositoryCreator new
		githubUrl: 'github://demarey/pharo-counter:master';
		location: self iceRepositoryLocation;
		create.
		
	self deny: repository iceRepository location exists.
	
	repository ensureCloned.
	
	self assert: repository iceRepository location exists.
	self
		assert: repository iceRepository branchName
		equals: 'master'