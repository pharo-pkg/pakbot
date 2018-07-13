tests
testNonConflictingDependencyResolutionsHaveNoConflictingDependencies

	| project testRegistry resolution configurationProjectV1 |
	testRegistry := CGOPackageRegistry new.	
	project := testRegistry newProjectNamed: 'Test'.
	
	configurationProjectV1 := PBMetacelloConfigurationProjectDependency
		name: 'CargoTestExample'
		repositoryUrl: 'http://smalltalkhub.com/mc/Pharo/CargoTestRepository/main'
		version: '1.0'.
	project addDependency: configurationProjectV1.
	resolution := project resolve.

	self assert: (resolution resolutionFor: configurationProjectV1) conflictingDependencies isEmpty.
	self deny: (resolution resolutionFor: configurationProjectV1) hasConflicts.