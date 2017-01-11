tests
testFromSton
	| project |
	
	project := STON fromString: self stonStringForExampleProject.
	
	self
		assert: project
		equals: CGOOngoingProject example asCargoProject.
		
	self assert: project authors isEmpty.
	self 
		assertCollection: project packageUnitNames
		hasSameElements: #('Package1' 'Package2')