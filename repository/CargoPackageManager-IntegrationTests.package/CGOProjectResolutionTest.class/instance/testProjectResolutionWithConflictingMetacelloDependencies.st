tests
testProjectResolutionWithConflictingMetacelloDependencies

	| project testRegistry resolution configurationProjectV1 configurationProjectV2 |
	testRegistry := CGOPackageRegistry new.	
	project := testRegistry newProjectNamed: 'Test'.
	
	configurationProjectV1 := CGOMetacelloConfigurationProject
		configuration: 'CargoTestExample'
		repositoryUrl: 'http://smalltalkhub.com/mc/Pharo/CargoTestRepository/main'
		version: '1.0'.

	configurationProjectV2 := CGOMetacelloConfigurationProject
		configuration: 'CargoTestExample'
		repositoryUrl: 'http://smalltalkhub.com/mc/Pharo/CargoTestRepository/main'
		version: '2.0'.
	
	project addDependency: configurationProjectV1.
	project addDependency: configurationProjectV2.

1halt.	
	resolution := testRegistry newSolver solveProject: project.

"	self assert: (resolution includesVersion: project).
	self assert: (resolution includesVersion: configurationProject).
	self assert: resolution resolvedVersions size equals: 2."