tests
testProjectLoadingWithMetacelloDependenciesLoadsMetacelloPackage

	| project testRegistry resolution configurationProject |
	testRegistry := CGOPackageRegistry new.	
	project := testRegistry newProjectNamed: 'Test'.
	
	configurationProject := CGOMetacelloConfigurationProject
		configuration: 'CargoTestExample'
		repositoryUrl: 'http://smalltalkhub.com/mc/Pharo/CargoTestRepository/main'
		version: '1.0'.
	
	project addDependency: configurationProject.
	
	resolution := testRegistry newSolver solveProject: project.
	resolution load.
	
	self assert: project isLoaded.
	self assert: project isUpToDate.