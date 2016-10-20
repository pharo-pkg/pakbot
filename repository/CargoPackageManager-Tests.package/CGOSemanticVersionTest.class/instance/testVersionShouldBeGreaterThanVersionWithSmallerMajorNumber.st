tests-comparison
testVersionShouldBeGreaterThanVersionWithSmallerMajorNumber

	self assert: self v2 > self v1.
	
	self assert: self v21 > self v10.
	self assert: self v20 > self v11.
	
	self assert: self v210 > self v101.
	self assert: self v211 > self v100.
	
	self assert: self v201 > self v100.
	self assert: self v200 > self v101.