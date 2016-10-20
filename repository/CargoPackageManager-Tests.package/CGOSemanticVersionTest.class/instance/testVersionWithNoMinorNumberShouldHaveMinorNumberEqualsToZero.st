tests-comparison
testVersionWithNoMinorNumberShouldHaveMinorNumberEqualsToZero
	| v1 v2 |
	
	v1 := SemanticVersion fromString: '1'.
	v2 := SemanticVersion fromString: '1.0'.

	self assert: self v1 equals: self v10.