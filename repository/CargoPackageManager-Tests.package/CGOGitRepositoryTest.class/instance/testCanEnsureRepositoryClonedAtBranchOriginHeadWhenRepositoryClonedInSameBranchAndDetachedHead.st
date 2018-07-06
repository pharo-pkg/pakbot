tests
testCanEnsureRepositoryClonedAtBranchOriginHeadWhenRepositoryClonedInSameBranchAndDetachedHead
	| iceRepository location |
	location := self gitRepoUniqueLocation.
	iceRepository := IceRepositoryCreator new 
			addRemote: 'git@github.com:demarey/pharo-counter';
			subdirectory: '';
			location: location;
			createRepository.
	(iceRepository lookupCommit: 'c1c1ef63933790a364501cdb991b18c589516729') checkout.
	repository := CGOGitRepositoryCreator new
		githubUrl: 'github://demarey/pharo-counter:master';
		location: location;
		create.
	
	self 
		assert: iceRepository headCommit id
		equals: 'c1c1ef63933790a364501cdb991b18c589516729'.
	
	repository ensureCloned.
	
	self 
		assert: repository currentCommitId
		equals: '61e71ff1f118f48bda23f3765400cfd51f10d147'.