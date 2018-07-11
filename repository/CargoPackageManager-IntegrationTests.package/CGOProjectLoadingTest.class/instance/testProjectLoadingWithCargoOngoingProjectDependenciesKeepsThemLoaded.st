tests
testProjectLoadingWithCargoOngoingProjectDependenciesKeepsThemLoaded

	| testRegistry projectOne projectTwo |
	testRegistry := CGOPackageRegistry new.	
	
	projectOne := testRegistry newProjectNamed: 'ProjectOne'.
	projectOne addDependency: (CGOCargoProjectDependency
		named: 'ProjectTwo'
		version: '=0.0.0-N/A').
		
	projectTwo := testRegistry newProjectNamed: 'ProjectTwo'.

	projectOne load.
	
	self assert: projectOne isLoaded.
	self assert: projectTwo isLoaded.
	self assert: projectOne isUpToDate.