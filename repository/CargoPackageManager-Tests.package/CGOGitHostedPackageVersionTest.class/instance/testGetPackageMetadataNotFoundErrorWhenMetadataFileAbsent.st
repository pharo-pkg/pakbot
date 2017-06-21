tests
testGetPackageMetadataNotFoundErrorWhenMetadataFileAbsent
	self should: 
		[ (CGOGitHostedPackageVersion
			repositoryUrl: 'git@github.com:demarey/pharo-counter.git'
			subdirectory: ''
			packageName: #Foo
			commitish: 'master') loadMetadata ]
		raise: CGOPackageMetadataNotFound