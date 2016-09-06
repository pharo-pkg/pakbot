tests
testGreaterThan2
	| v1 v2 |
	
	v1 := SemanticVersion fromString: '2.4.8'.
	v2 := SemanticVersion fromString: '2.5.1'.
	
	self deny: v1> v2.
	self assert: v2 > v1