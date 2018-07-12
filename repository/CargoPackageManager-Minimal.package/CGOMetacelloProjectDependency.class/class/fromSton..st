ston
fromSton: stonReader
	| metacelloProject |
	
	metacelloProject := super fromSton: stonReader.
	^ metacelloProject 
		initializeWithName: metacelloProject name 
		repositoryUrl: metacelloProject repositoryUrl
		version: metacelloProject version