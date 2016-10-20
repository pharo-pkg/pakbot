tests
test
	| reader |
	reader := CGOPackageVersionReader new on: self bar300Ston readStream.
	self assert: reader next equals: (CGOPackageVersion fromString: 'Bar@3.0.0')