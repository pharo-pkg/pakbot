ston
fromSton: stonReader
	| repository |
	
	repository := super fromSton: stonReader.
	^ repository 
		initializeWithName: repository configuration 
		repositoryUrl: repository repositoryUrl
		version: repository version