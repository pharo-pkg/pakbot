tests - versions fetching
testBleedingEdgeFor
	| result |
	
	result := repository 
				latestVersionOfPackage: #'Zinc-HTTP'
				suitableForEnvironment: #().
	self 
		assert: result asString
		equals: 'Zinc-HTTP@2.5.2'