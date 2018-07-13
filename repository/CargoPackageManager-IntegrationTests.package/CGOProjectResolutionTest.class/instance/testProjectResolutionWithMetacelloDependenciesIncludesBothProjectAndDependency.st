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
	
	resolution := project resolve.

	self assert: (resolution includesResolvedTarget: project).
	self assert: (resolution includesResolvedTarget: (PBMetacelloBaselineProject fromProjectDependency: configurationProject)).