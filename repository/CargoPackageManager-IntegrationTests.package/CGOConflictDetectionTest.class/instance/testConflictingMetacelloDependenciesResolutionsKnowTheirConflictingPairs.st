tests
testConflictingMetacelloDependenciesResolutionsKnowTheirConflictingPairs

	| project testRegistry resolution configurationProjectV1 configurationProjectV2 v1Resolution v2Resolution |
	testRegistry := CGOPackageRegistry new.	
	project := testRegistry newProjectNamed: 'Test'.
	
	configurationProjectV1 := PBMetacelloConfigurationProjectDependency
		name: 'CargoTestExample'
		repositoryUrl: 'http://smalltalkhub.com/mc/Pharo/CargoTestRepository/main'
		version: '1.0'.

	configurationProjectV2 := PBMetacelloConfigurationProjectDependency
		name: 'CargoTestExample'
		repositoryUrl: 'http://smalltalkhub.com/mc/Pharo/CargoTestRepository/main'
		version: '2.0'.
	
	project addDependency: configurationProjectV1.
	project addDependency: configurationProjectV2.	
	resolution := project resolve.

	v1Resolution := resolution resolutionFor: configurationProjectV1.
	v2Resolution := resolution resolutionFor: configurationProjectV2.

	self assert: (v1Resolution conflictingDependencies includes: v2Resolution).
	self assert: v1Resolution conflictingDependencies size equals: 1