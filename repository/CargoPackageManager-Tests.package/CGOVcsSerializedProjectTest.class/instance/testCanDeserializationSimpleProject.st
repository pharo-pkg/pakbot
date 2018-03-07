tests
testCanDeserializationSimpleProject
	| project packageUnit |
	
	project := CGOOngoingProject fromStonString: self stonStringForExampleProject.
	
	self
		assert: project
		equals: CGOOngoingProject example asOngoingProject.
		
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
	