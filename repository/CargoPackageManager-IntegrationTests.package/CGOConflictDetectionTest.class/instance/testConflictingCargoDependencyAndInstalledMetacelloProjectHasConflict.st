tests
testConflictingCargoDependencyAndInstalledMetacelloProjectHasConflict

	<expectedFailure>
	| project testRegistry resolution configurationProjectV1 project2 configurationProjectV2 |
	testRegistry := CGOPackageRegistry new.	

	project := testRegistry newProjectNamed: 'Test'.
	configurationProjectV1 := CGOMetacelloConfigurationProjectDependency
		configuration: 'CargoTestExample'
		repositoryUrl: 'http://smalltalkhub.com/mc/Pharo/CargoTestRepository/main'
		version: '1.0'.
	project addDependency: configurationProjectV1.
	project load.
	
	project2 := testRegistry newProjectNamed: 'Test2'.
	configurationProjectV2 := CGOCargoProjectDependency
		named: 'CargoTestExample'
		version: '=2.0.0-N/A'.
	project2 addDependency: configurationProjectV2.

	resolution := project2 resolve.
	self assert: resolution hasConflicts