building
buildExternalProjectDependencies
	project addExternalCargoProject: 
		(CGOMetacelloConfigurationProject
			configuration: 'JSON' 
			repositoryUrl: 'http://smalltalkhub.com/mc/PharoExtras/JSON/main/'
			version: #stable).
	project addExternalCargoProject: 
		(CGOMetacelloConfigurationProject 
			configuration: 'Ston'
			repositoryUrl: 'http://ss3.gemstone.com/ss/STON'
			version: #stable).
	project addExternalCargoProject: 
		(CGOMetacelloConfigurationProject 
			configuration: 'OSProcess'
			repositoryUrl: 'http://www.squeaksource.com/MetacelloRepository'
			version: #stable).
	project addExternalCargoProject: 
		(CGOMetacelloConfigurationProject 
			configuration: 'ProcessWrapper'
			repositoryUrl: 'http://smalltalkhub.com/mc/hernan/ProcessWrapper/main/'
			version: #bleedingEdge).
	project addExternalCargoProject: 
		(CGOMetacelloConfigurationProject 
			configuration: 'XMLParser'
			repositoryUrl: 'hhttp://smalltalkhub.com/mc/PharoExtras/XMLParser/main/'
			version: #stable).