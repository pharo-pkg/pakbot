tests
testCanDeserializationSimpleProject
	| project packageUnit |
	
	project := CGOOngoingProject fromStonString: self stonStringForExampleProject.
	
	self
		assert: project
		equals: CGOOngoingProject example.
		
	self assert: project assemblies isEmpty.
	self 
		assertCollection: project packageUnitNames asArray
		hasSameElements: #('UnitTest').

	packageUnit := project packageUnits anyOne.
	self
		assert: packageUnit project 
		equals: project.
	self
		assertCollection: packageUnit platformRequirements 
		hasSameElements: #()
	