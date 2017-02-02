tests
testCanGetProjectFromRegistry
	self
		assert: self unitTestV1 project 
		equals: ongoingProject 