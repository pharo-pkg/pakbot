tests
testConflictingMetacelloAndCargoDependenciesHasConflicts

	| project testRegistry resolution configurationProjectV1 configurationProjectV2 |
	testRegistry := CGOPackageRegistry new.	
	project := testRegistry newProjectNamed: 'Test'.
	testRegistry newProjectNamed: 'CargoTestExample'.
	
	configurationProjectV1 := PBMetacelloConfigurationProjectDependency
		name: 'CargoTestExample'
		repositoryUrl: 'http://smalltalkhub.com/mc/Pharo/CargoTestRepository/main'
		version: '1.0'.

	configurationProjectV2 := CGOCargoProjectDependency
		named: 'CargoTestExample'
		version: '=0.0.0-N/A'.

	project addDependency: configurationProjectV1.
	project addDependency: configurationProjectV2.	
	resolution := project resolve.

	self assert: resolution hasConflicts