tests
testProjectResolutionWithMetacelloDependenciesIncludesBothProjectAndDependency

	| project testRegistry resolution configurationProject |
	testRegistry := CGOPackageRegistry new.	
	project := testRegistry newProjectNamed: 'Test'.
	
	configurationProject := CGOMetacelloConfigurationProject
		configuration: 'CargoTestExample'
		repositoryUrl: 'http://smalltalkhub.com/mc/Pharo/CargoTestRepository/main'
		version: '1.0'.
	
	project addDependency: configurationProject.
	
	resolution := testRegistry newSolver solveProject: project.

	self assert: (resolution includesVersion: project).
	self assert: (resolution includesVersion: configurationProject).
	self assert: resolution resolvedVersions size equals: 2.