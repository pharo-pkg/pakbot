serialization
fromSton: stonReader
	super fromSton: stonReader.
	self isGitRepositoryUrl
		ifFalse: [ repositoryUrl := repositoryUrl asUrl ]