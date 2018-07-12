tests
testProjectWithoutDependenciesResolvesToItself

	| project testRegistry resolution |
	testRegistry := CGOPackageRegistry new.	
	project := testRegistry newProjectNamed: 'Test'.
	
	resolution := testRegistry newSolver solveProject: project.

	self assert: (resolution includesResolvedTarget: project)