tests
testCanGetProjectFromRegistry
	| project |
	project := ongoingProject asCargoProject.
	registry register: project.
	
	self
		assert: self unitTestV1 project 
		equals: project