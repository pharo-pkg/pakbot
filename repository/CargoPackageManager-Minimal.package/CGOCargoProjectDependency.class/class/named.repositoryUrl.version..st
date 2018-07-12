instance creation
named: aName repositoryUrl: gitUrlString version: aCommitish

	^ self new 
		name: aName;
		repository: (CGOGitRepositoryCreator repositoryFromUrl: gitUrlString);
		version: aCommitish;
		yourself