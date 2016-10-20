tests-comparison
testVersionShouldBeGreaterThanVersionWithEqualMajorAndSmallerMinorNumber

	self assert: self v11 > self v10.
	
	self assert: self v110 > self v101.
	self assert: self v111 > self v101.