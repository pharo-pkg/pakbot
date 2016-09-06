tests - versions fetching
testFetchVersion
	| result |
	
	result := repository 
				fetch: #'Seaside-Core'
				version: '3.1' asSemanticVersion.
	self 
		assert: result asString
		equals: 'Seaside-Core@3.1.0'