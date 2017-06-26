tests
testCanGetCurrentImageEnvironment
	| environment |
	environment := CGOEnvironment current.
	
	self 
		assert: environment smalltalkVendor
		equals: 'Pharo'.
	self assert: environment smalltalkVersion asNumber > 5.0		
	