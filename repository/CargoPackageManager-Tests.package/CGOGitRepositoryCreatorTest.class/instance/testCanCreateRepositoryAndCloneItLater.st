tests
testCanCreateRepositoryAndCloneItLater
	| repository repoFolder |
	repository := CGOGitRepositoryCreator
		repositoryFromUrl: 'github://demarey/pharo-counter:cb8e640dc048b26beba3ff55e7c0fa8127a0716e'.
		
	self 
		assert: repository class
		equals: CGOGitRepository.
	self
		assert: repository iceRepository remote url
		equals: 'git@github.com:demarey/pharo-counter.git'.
	
	repoFolder := (FileLocator temp / 'pharo-counter') asFileReference ensureDeleteAll.
	repository iceRepository location: repoFolder.
	repository ensureCloned.
	
	self assert: (repository iceRepository isKindOf: IceRepository).
	self assert: repoFolder hasChildren.
	
	self 
		assert: repository iceRepository headCommit id
		equals: repository version