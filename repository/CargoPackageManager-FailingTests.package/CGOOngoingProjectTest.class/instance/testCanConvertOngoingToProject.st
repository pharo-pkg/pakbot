tests
testCanConvertOngoingToProject
	| project |
	project := ongoingProject asCargoProject.
	
	self 
		assert: project class
		equals: CGOProject.
	
	self 
		assert: project packageName
		equals: ongoingProject packageName.
		
	self 
		assert: project version
		equals: ongoingProject version.
		
	self
		assert: project packageUnitNames
		equals: ongoingProject packageUnitNames asArray