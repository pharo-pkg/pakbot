tests
testGreaterThan
	| v1 v2 |
	
	v1 := SemanticVersion fromString: '1.0'.
	v2 := SemanticVersion fromString: '1.0'.
	
	self deny: v1> v2.

	v1:= SemanticVersion fromString: '1.1'.
	self assert: v1 > v2.
		
	v2 := SemanticVersion fromString: '2.0'.
	self assert: v2 > v1.