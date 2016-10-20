tests-comparison
testVersionWithNoPatchNumberShouldHavePatchNumberEqualsToZero
	| v1 v2 |
	
	v1 := SemanticVersion fromString: '1.1'.
	v2 := SemanticVersion fromString: '1.1.0'.

	self assert: self v11 equals: self v110.