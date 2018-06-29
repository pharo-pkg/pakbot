ston
fromSton: stonReader
	| repository |
	
	repository := super fromSton: stonReader.
	^ repository initializeWithRepositoryUrl: repository repositoryUrl version: repository version