building
buildExternalProjectDependencies
	project addExternalCargoProject: 
		#Json -> (CGOMetacelloConfigurationProjectDependency 
			repositoryUrl: 'http://smalltalkhub.com/mc/PharoExtras/JSON/main/'
			version: #stable).
	project addExternalCargoProject: 
		#Ston -> (CGOMetacelloConfigurationProjectDependency 
			repositoryUrl: 'http://ss3.gemstone.com/ss/STON'
			version: #stable).
	project addExternalCargoProject: 
		#OSProcess -> (CGOMetacelloConfigurationProjectDependency 
			repositoryUrl: 'http://www.squeaksource.com/MetacelloRepository'
			version: #stable).
	project addExternalCargoProject: 
		#ProcessWrapper -> (CGOMetacelloConfigurationProjectDependency 
			repositoryUrl: 'http://smalltalkhub.com/mc/hernan/ProcessWrapper/main/'
			version: #bleedingEdge).
	project addExternalCargoProject: 
		#ProcessWrapper -> (CGOMetacelloConfigurationProjectDependency 
			repositoryUrl: 'hhttp://smalltalkhub.com/mc/PharoExtras/XMLParser/main/'
			version: #stable).