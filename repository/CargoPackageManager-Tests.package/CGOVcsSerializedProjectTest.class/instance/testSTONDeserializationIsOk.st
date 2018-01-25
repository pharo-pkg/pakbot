tests
testSTONDeserializationIsOk
	| project packageUnit |
	
	project := CGOOngoingProject2 fromStonString: self stonStringForExampleProject.
	
	self
		assert: project
		equals: CGOOngoingProject2 example asOngoingProject.
		
	self assert: project assemblies isEmpty.
	self 
		assertCollection: project packageUnitNames asArray
		hasSameElements: #('Test').

	packageUnit := project packageUnits anyOne.
	self
		assert: packageUnit project 
		equals: project.
	self
		assertCollection: packageUnit platformRequirements 
		hasSameElements: #()
	