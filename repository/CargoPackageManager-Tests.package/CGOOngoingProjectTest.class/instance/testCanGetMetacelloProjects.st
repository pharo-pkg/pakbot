tests
testCanGetMetacelloProjects
	| metacelloProjects |
	ongoingProject 
		addExternalCargoProject: 
			(PBMetacelloConfigurationProjectDependency
				name: 'Ston'
				repositoryUrl: 'http://ss3.gemstone.com/ss/STON'
				version: #stable).
				
	metacelloProjects := ongoingProject metacelloProjects.
	self 
		assert: metacelloProjects size 
		equals: 1.

	self 
		assert: metacelloProjects anyOne name
		equals: 'Ston'.
	
	self
		assert: metacelloProjects anyOne version
		equals: #stable.
		
	self 	
		assert: metacelloProjects anyOne repository
		equals: 'http://ss3.gemstone.com/ss/STON' asZnUrl.