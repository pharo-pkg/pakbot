tests
testCanCreateOngoingProject
	
	self
		assert: ongoingProject class 
		equals: CGOOngoingProject2.
	self
		assert: ongoingProject packageName
		equals: #'MyProject'.
	self 
		assert: ongoingProject description
		equals: 'A simple project used for illustration.'.	
	self 
		assert: ongoingProject packageUnits size 
		equals: 1.
	self 
		assert: ongoingProject packageUnits anyOne class
		equals: CGOOngoingPackageUnit2.
	self 
		assert: ongoingProject packageUnits anyOne project
		equals: ongoingProject.