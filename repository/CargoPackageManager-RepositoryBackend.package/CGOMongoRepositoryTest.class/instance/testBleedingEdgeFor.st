tests - versions fetching
testBleedingEdgeFor
	| result |
	
	result := repository 
				bleedingEdgeOf: #'Zinc-HTTP'
				for: #().
	self 
		assert: result first asString
		equals: 'Zinc-HTTP@2.5.2'