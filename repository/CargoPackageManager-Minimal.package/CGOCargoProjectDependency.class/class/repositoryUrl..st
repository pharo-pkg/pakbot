instance creation
repositoryUrl: urlOrString 
	^ self repository: 
		(CGOGitRepositoryCreator repositoryFromUrl: urlOrString)