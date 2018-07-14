tests
testProjectResolutionWithCargoDependenciesIncludesBothProjectAndDependency

	| project testRegistry resolution configurationProject |
	testRegistry := CGOPackageRegistry new.	
	project := testRegistry newProjectNamed: 'Test'.
	
	configurationProject := CGOCargoProjectDependency
		named: 'test-project-source-properties-tonel'
		repositoryUrl: 'git@github.com:pharo-vcs/test-project-source-properties-tonel.git'.
	
	project addDependency: configurationProject.
	resolution := project resolve.

	self assert: (resolution includesResolvedTarget: project).
	self assert: (resolution includesResolvedTarget: self expectedCargoResolvedProject).