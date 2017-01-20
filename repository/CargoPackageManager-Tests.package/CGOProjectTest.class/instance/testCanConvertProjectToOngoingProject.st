tests
testCanConvertProjectToOngoingProject
	| project |
	project := ongoingProject asCargoProject asOngoingProject.
	
	self 
		assert: project class
		equals: CGOOngoingProject.
	
	self 
		assert: project name
		equals: ongoingProject name.
		
	self
		assertCollection: project packageUnitNames
		hasSameElements: ongoingProject packageUnitNames