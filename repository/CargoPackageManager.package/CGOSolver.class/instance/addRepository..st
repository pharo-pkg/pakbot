adding
addRepository: aRepositoryUrl
	(repositories includes: aRepositoryUrl)
		ifFalse: [ repositories add: aRepositoryUrl ]