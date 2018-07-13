tests
testConflictingMetacelloAndCargoDependenciesThenResolvedDependenciesHaveEachOtherConflict

	| project testRegistry resolution configurationProjectV1 configurationProjectV2 resolutionOfV1 resolutionOfV2 |
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

	resolutionOfV1 := resolution resolutionFor: configurationProjectV1.
	resolutionOfV2 := resolution resolutionFor: configurationProjectV2.
	
	self assert: (resolutionOfV1 conflictingDependencies includes: resolutionOfV2).
	self assert: (resolutionOfV2 conflictingDependencies includes: resolutionOfV1)