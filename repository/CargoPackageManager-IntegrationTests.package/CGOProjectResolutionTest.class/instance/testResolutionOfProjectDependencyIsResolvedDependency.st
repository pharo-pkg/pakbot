tests
testResolutionOfProjectDependencyIsResolvedDependency

	| testRegistry resolution projectOne configurationProject |
	testRegistry := CGOPackageRegistry new.	
	
	projectOne := testRegistry newProjectNamed: 'ProjectOne'.
	configurationProject := CGOMetacelloConfigurationProject
		configuration: 'CargoTestExample'
		repositoryUrl: 'http://smalltalkhub.com/mc/Pharo/CargoTestRepository/main'
		version: '1.0'.
	projectOne addDependency: configurationProject.
	resolution := projectOne resolve.
	
	self assert: resolution resolvedDependencies anyOne equals: (resolution resolutionFor: configurationProject)