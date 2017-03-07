tests
testCanGetProjectFromRegistry
	| project |
	project := ongoingProject asCargoProject.
	[ registry register: project ]
		on: CGOPackageAlreadyRegistered 
		do: [ "ignore" ].
	
	self
		assert: self unitTestV1 project 
		equals: project