instance creation
fromSton: stonReader
	| repository |
	
	repository := super fromSton: stonReader.
	^ self repository: 
		(CGOGitRepositoryCreator new
			url: repository	repositoryUrl;
			create)