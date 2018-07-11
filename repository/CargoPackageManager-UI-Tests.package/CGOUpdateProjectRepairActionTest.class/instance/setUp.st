running
setUp
	super setUp.
	registry := CGOPackageRegistry new.
	project := CGOOngoingProject named: 'ATestProject'.
	registry register: project.

	dependencyToProject := (CGOMetacelloConfigurationProject  
		configuration: 'CargoTestExample'
		repositoryUrl: 'http://smalltalkhub.com/mc/Pharo/CargoTestRepository/main'
		version: '2.0').

	project newPackageUnit: #APackage.
	project addDependency: dependencyToProject