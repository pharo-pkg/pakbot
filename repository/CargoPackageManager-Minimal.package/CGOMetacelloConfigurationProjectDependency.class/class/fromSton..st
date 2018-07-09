ston
fromSton: stonReader
	| metacelloConfigDependency |
	
	metacelloConfigDependency := super fromSton: stonReader.
	^ metacelloConfigDependency 
		initializeWithName: metacelloConfigDependency name 
		repositoryUrl: metacelloConfigDependency repositoryUrl
		version: metacelloConfigDependency version