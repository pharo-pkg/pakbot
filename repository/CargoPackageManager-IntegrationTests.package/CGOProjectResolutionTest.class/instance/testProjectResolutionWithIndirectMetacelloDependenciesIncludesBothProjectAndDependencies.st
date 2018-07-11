tests
testProjectResolutionWithIndirectMetacelloDependenciesIncludesBothProjectAndDependencies

	| projectOne projectTwo testRegistry resolution configurationProject |
	testRegistry := CGOPackageRegistry new.	
	projectOne := testRegistry newProjectNamed: 'ProjectOne'.
	projectOne addDependency: (CGOCargoProjectDependency
		named: 'ProjectTwo'
		version: '=0.0.0-N/A').
		
	projectTwo := testRegistry newProjectNamed: 'ProjectTwo'.
	configurationProject := CGOMetacelloConfigurationProject
		configuration: 'CargoTestExample'
		repositoryUrl: 'http://smalltalkhub.com/mc/Pharo/CargoTestRepository/main'
		version: '1.0'.
	projectTwo addDependency: configurationProject.
	
	resolution := projectOne resolution.

	self assert: (resolution includesVersion: projectOne).
	self assert: (resolution includesVersion: projectTwo).
	self assert: (resolution includesVersion: configurationProject).
	self assert: resolution resolvedVersions size equals: 3.