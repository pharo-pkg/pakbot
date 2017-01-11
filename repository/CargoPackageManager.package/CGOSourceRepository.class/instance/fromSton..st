serialization
fromSton: stonReader
	super fromSton: stonReader.
	(repositoryUrl beginsWith: 'git@')
		ifFalse: [ repositoryUrl := repositoryUrl asUrl ]