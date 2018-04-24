tests
testCanGetProjectFromAssembly
	| project |
	project := ongoingProject asCargoProject.
	
	self
		assert: self assemblyA1 project 
		equals: project