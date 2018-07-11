tests
testProjectLoadingWithCargoOngoingProjectDependenciesKeepsThemLoaded

	| testRegistry resolution projectOne projectTwo |
	testRegistry := CGOPackageRegistry new.	
	
	projectOne := testRegistry newProjectNamed: 'ProjectOne'.
	projectOne addDependency: (CGOCargoProjectDependency
		named: 'ProjectTwo'
		version: '=0.0.0-N/A').
		
	projectTwo := testRegistry newProjectNamed: 'ProjectTwo'.

	resolution := testRegistry newSolver solveProject: projectOne.

	resolution load.
	
	self assert: projectOne isLoaded.
	self assert: projectTwo isLoaded.
	self assert: projectOne isUpToDate.