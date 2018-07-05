tests
testCanDeserializeAPackageDependencyOnExternalCargoProject
	| project dependency externalProject |
	
	project := CGOOngoingProject fromStonString: self counterUiStonString.
	
	dependency := project packageUnits anyOne dependencies first.
	self 
		assert: dependency targetedPackage
		equals: 'Counter::Counter-Core'.
	
	self 
		assert: project externalProjects size 
		equals: 1.
	self 
		assert: project externalProjects keys anyOne
		equals: #Counter.
			
	externalProject := project externalProjects anyOne.
	self
		assert: externalProject class 
		equals: CGOCargoProjectDependency.
	self
		assert: externalProject repositoryUrl 
		equals: 'git@github.com:demarey/pharo-counter-ui.git'.