tests
testCanGetMetacelloProjects
	| metacelloProjects |
	ongoingProject 
		addExternalCargoProject: 
			#Ston -> (CGOMetacelloConfigurationProjectDependency 
				repositoryUrl: 'http://ss3.gemstone.com/ss/STON'
				version: #stable).
				
	metacelloProjects := ongoingProject metacelloProjects.
	self 
		assert: metacelloProjects size 
		equals: 1.
	metacelloProjects first inspect