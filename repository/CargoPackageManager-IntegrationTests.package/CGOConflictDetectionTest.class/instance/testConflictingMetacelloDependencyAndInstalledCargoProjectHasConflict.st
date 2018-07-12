tests
testConflictingMetacelloDependencyAndInstalledCargoProjectHasConflict

	| project testRegistry resolution configurationProjectV1 |
	testRegistry := CGOPackageRegistry new.	
	project := testRegistry newProjectNamed: 'Test'.
	testRegistry newProjectNamed: 'CargoTestExample'.
	
	configurationProjectV1 := CGOMetacelloConfigurationProjectDependency
		configuration: 'CargoTestExample'
		repositoryUrl: 'http://smalltalkhub.com/mc/Pharo/CargoTestRepository/main'
		version: '1.0'.

	project addDependency: configurationProjectV1.
	resolution := project resolve.

	self assert: resolution hasConflicts