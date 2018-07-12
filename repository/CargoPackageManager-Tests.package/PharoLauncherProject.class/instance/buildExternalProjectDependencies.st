building
buildExternalProjectDependencies
	project addExternalCargoProject: 
		(CGOMetacelloConfigurationProject
			name: 'JSON' 
			repositoryUrl: 'http://smalltalkhub.com/mc/PharoExtras/JSON/main/'
			version: #stable).
	project addExternalCargoProject: 
		(CGOMetacelloConfigurationProject 
			name: 'Ston'
			repositoryUrl: 'http://ss3.gemstone.com/ss/STON'
			version: #stable).
	project addExternalCargoProject: 
		(CGOMetacelloConfigurationProject 
			name: 'OSProcess'
			repositoryUrl: 'http://www.squeaksource.com/MetacelloRepository'
			version: #stable).
	project addExternalCargoProject: 
		(CGOMetacelloConfigurationProject 
			name: 'ProcessWrapper'
			repositoryUrl: 'http://smalltalkhub.com/mc/hernan/ProcessWrapper/main/'
			version: #bleedingEdge).
	project addExternalCargoProject: 
		(CGOMetacelloConfigurationProject 
			name: 'XMLParser'
			repositoryUrl: 'hhttp://smalltalkhub.com/mc/PharoExtras/XMLParser/main/'
			version: #stable).