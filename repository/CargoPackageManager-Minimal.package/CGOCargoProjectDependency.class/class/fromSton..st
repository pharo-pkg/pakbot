instance creation
fromSton: stonReader
	| repository |
	
	repository := super fromSton: stonReader.
	^ self named: repository name repositoryUrl: repository	repositoryUrl