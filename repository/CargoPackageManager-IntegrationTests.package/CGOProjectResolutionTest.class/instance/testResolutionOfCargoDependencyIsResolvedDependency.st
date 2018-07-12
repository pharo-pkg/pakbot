tests
testResolutionOfCargoDependencyIsResolvedDependency

	| testRegistry resolution projectOne configurationProject |
	testRegistry := CGOPackageRegistry new.	
	
	projectOne := testRegistry newProjectNamed: 'ProjectOne'.
	configurationProject := CGOCargoProjectDependency
		named: 'test-project-source-properties-tonel'
		repositoryUrl: 'git@github.com:pharo-vcs/test-project-source-properties-tonel.git'.
	projectOne addDependency: configurationProject.
	resolution := projectOne resolve.

	self assert: resolution resolvedDependencies anyOne equals: (resolution resolutionFor: configurationProject)