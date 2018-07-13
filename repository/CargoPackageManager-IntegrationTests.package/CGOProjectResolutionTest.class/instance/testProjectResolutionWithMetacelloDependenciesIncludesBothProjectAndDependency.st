tests
testProjectResolutionWithMetacelloDependenciesIncludesBothProjectAndDependency

	| project testRegistry resolution configurationProject |
	testRegistry := CGOPackageRegistry new.	
	project := testRegistry newProjectNamed: 'Test'.
	
	configurationProject := PBMetacelloConfigurationProjectDependency
		name: 'CargoTestProject'
		repositoryUrl: 'http://smalltalkhub.com/mc/PharoExtras/JSON/main/'
		version: '1.0'.
	
	project addDependency: configurationProject.
	
	resolution := CGOSolver new
		repositories: { testRegistry };
		solveProject: project.

	self assert: (resolution includesVersion: project).
	self assert: (resolution includesVersion: configurationProject).
	self assert: resolution resolvedVersions size equals: 2.