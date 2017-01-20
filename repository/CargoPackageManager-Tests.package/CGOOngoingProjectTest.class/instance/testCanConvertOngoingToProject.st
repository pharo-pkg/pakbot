tests
testCanConvertOngoingToProject
	| project |
	project := ongoingProject asCargoProject.
	
	self 
		assert: project class
		equals: CGOProject.
	
	self 
		assert: project name
		equals: ongoingProject name.
		
	self
		assert: project packageUnitNames
		equals: ongoingProject packageUnitNames asArray