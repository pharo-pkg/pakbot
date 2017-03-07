tests
testCanGetProjectFromRegistry
	| project |
	project := ongoingProject asCargoProject.
	[ registry register: project ]
		on: CGOPackageAlreadyRegistered 
		do: [ "ignore" ].
	
	self
		assert: self assemblyA1 project 
		equals: project