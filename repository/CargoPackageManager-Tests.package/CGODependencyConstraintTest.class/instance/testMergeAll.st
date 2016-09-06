tests
testMergeAll
	| c1 c2 result |
	
	c1 := CGOFixedVersionConstraint with: '3.0' asSemanticVersion.
	c2 := CGOFixedVersionConstraint with: '3.0' asSemanticVersion.
		
	result := (c2 mergeAll: { c1 . c1 }).
	self 
		assert: result
		equals: { c1 . c1 }.
		
	result := (c2 mergeAll: #()).
	self 
		assert: result
		equals: c2 asOrderedCollection