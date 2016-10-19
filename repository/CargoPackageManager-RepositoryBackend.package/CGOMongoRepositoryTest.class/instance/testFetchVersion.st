tests - versions fetching
testFetchVersion
	| result |
	
	self flag: 'This test is failing randomly: sometimes success, sometimes error. Skip it till it has a reproducible status'.
	^ self skip.
	
	"result := repository 
				fetch: #'Seaside-Core'
				version: '3.1' asSemanticVersion.
	self 
		assert: result asString
		equals: 'Seaside-Core@3.1.0'"