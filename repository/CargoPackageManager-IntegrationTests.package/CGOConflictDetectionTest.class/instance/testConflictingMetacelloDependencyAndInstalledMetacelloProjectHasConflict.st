tests
testConflictingMetacelloDependencyAndInstalledMetacelloProjectHasConflict

	| project testRegistry resolution configurationProjectV1 project2 |
	testRegistry := CGOPackageRegistry new.	

	project := testRegistry newProjectNamed: 'Test'.
	configurationProjectV1 := CGOMetacelloConfigurationProject
		configuration: 'CargoTestExample'
		repositoryUrl: 'http://smalltalkhub.com/mc/Pharo/CargoTestRepository/main'
		version: '1.0'.
	project addDependency: configurationProjectV1.
	project load.
	
	project2 := testRegistry newProjectNamed: 'Test2'.
	configurationProjectV1 := CGOMetacelloConfigurationProject
		configuration: 'CargoTestExample'
		repositoryUrl: 'http://smalltalkhub.com/mc/Pharo/CargoTestRepository/main'
		version: '2.0'.

	resolution := project2 resolve.	
	self assert: resolution hasConflicts