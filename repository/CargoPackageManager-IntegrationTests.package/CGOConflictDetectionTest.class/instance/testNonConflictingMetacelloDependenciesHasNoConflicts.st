tests
testNonConflictingMetacelloDependenciesHasNoConflicts

	| project testRegistry resolution configurationProjectV1 |
	testRegistry := CGOPackageRegistry new.	
	project := testRegistry newProjectNamed: 'Test'.
	
	configurationProjectV1 := CGOMetacelloConfigurationProject
		configuration: 'CargoTestExample'
		repositoryUrl: 'http://smalltalkhub.com/mc/Pharo/CargoTestRepository/main'
		version: '1.0'.
	project addDependency: configurationProjectV1.
	resolution := project resolve.

	self deny: resolution hasConflicts