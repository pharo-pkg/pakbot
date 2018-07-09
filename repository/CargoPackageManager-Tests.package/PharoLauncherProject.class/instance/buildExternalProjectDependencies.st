building
buildExternalProjectDependencies
	project addExternalCargoProject: 
		(CGOMetacelloConfigurationProjectDependency
			configuration: 'JSON' 
			repositoryUrl: 'http://smalltalkhub.com/mc/PharoExtras/JSON/main/'
			version: #stable).
	project addExternalCargoProject: 
		(CGOMetacelloConfigurationProjectDependency 
			configuration: 'Ston'
			repositoryUrl: 'http://ss3.gemstone.com/ss/STON'
			version: #stable).
	project addExternalCargoProject: 
		(CGOMetacelloConfigurationProjectDependency 
			configuration: 'OSProcess'
			repositoryUrl: 'http://www.squeaksource.com/MetacelloRepository'
			version: #stable).
	project addExternalCargoProject: 
		(CGOMetacelloConfigurationProjectDependency 
			configuration: 'ProcessWrapper'
			repositoryUrl: 'http://smalltalkhub.com/mc/hernan/ProcessWrapper/main/'
			version: #bleedingEdge).
	project addExternalCargoProject: 
		(CGOMetacelloConfigurationProjectDependency 
			configuration: 'XMLParser'
			repositoryUrl: 'hhttp://smalltalkhub.com/mc/PharoExtras/XMLParser/main/'
			version: #stable).