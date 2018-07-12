tests
testProjectResolutionWithCargoOngoingProjectDependenciesIncludesBothProjectAndDependency

	| testRegistry resolution projectOne projectTwo |
	testRegistry := CGOPackageRegistry new.	
	
	projectOne := testRegistry newProjectNamed: 'ProjectOne'.
	projectOne addDependency: (CGOCargoProjectDependency
		named: 'ProjectTwo'
		version: '=0.0.0-N/A').
		
	projectTwo := testRegistry newProjectNamed: 'ProjectTwo'.
	resolution := projectOne resolve.
	
	self assert: (resolution includesResolvedTarget: projectOne).
	self assert: (resolution includesResolvedTarget: projectTwo).