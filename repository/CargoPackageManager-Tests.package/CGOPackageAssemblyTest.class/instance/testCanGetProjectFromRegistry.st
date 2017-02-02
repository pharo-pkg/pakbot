tests
testCanGetProjectFromRegistry
	| project |
	project := ongoingProject asCargoProject.
	registry register: project.
	
	self
		assert: self assemblyA1 project 
		equals: project