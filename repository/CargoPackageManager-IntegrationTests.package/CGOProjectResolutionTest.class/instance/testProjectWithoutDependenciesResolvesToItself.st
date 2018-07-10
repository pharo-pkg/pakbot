tests
testProjectWithoutDependenciesResolvesToItself

	| project testRegistry resolution |
	testRegistry := CGOPackageRegistry new.	
	project := CGOOngoingProject example.
	testRegistry register: project.
	
	resolution := CGOSolver new
		repositories: { testRegistry };
		solveProject: project.

	self assert: (resolution includesVersion: project).
	self assert: resolution resolvedVersions size equals: 1.