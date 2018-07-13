building
buildExternalProjectDependencies
	project addExternalCargoProject: 
		(PBMetacelloConfigurationProjectDependency
			name: 'JSON' 
			repositoryUrl: 'http://smalltalkhub.com/mc/PharoExtras/JSON/main/'
			version: #stable).
	project addExternalCargoProject: 
		(PBMetacelloConfigurationProjectDependency 
			name: 'Ston'
			repositoryUrl: 'http://ss3.gemstone.com/ss/STON'
			version: #stable).
	project addExternalCargoProject: 
		(PBMetacelloConfigurationProjectDependency 
			name: 'OSProcess'
			repositoryUrl: 'http://www.squeaksource.com/MetacelloRepository'
			version: #stable).
	project addExternalCargoProject: 
		(PBMetacelloConfigurationProjectDependency 
			name: 'ProcessWrapper'
			repositoryUrl: 'http://smalltalkhub.com/mc/hernan/ProcessWrapper/main/'
			version: #bleedingEdge).
	project addExternalCargoProject: 
		(PBMetacelloConfigurationProjectDependency 
			name: 'XMLParser'
			repositoryUrl: 'hhttp://smalltalkhub.com/mc/PharoExtras/XMLParser/main/'
			version: #stable).