tests
testProjectWithoutDependenciesResolvesToItself

	| project testRegistry resolution |
	testRegistry := CGOPackageRegistry new.	
	project := testRegistry newProjectNamed: 'Test'.
	
	resolution := CGOSolver new
		repositories: { testRegistry };
		solveProject: project.

	self assert: (resolution includesVersion: project).
	self assert: resolution resolvedVersions size equals: 1.