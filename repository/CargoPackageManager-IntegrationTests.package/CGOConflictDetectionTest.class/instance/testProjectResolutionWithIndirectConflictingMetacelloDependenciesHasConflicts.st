tests
testProjectResolutionWithIndirectConflictingMetacelloDependenciesHasConflicts

	| testRegistry projectOne projectTwo |
	testRegistry := CGOPackageRegistry new.	
	projectOne := testRegistry newProjectNamed: 'ProjectOne'.
	projectOne addDependency: (CGOCargoProjectDependency
		named: 'ProjectTwo'
		version: '=0.0.0-N/A').
	projectOne addDependency: (CGOMetacelloConfigurationProject
		configuration: 'CargoTestExample'
		repositoryUrl: 'http://smalltalkhub.com/mc/Pharo/CargoTestRepository/main'
		version: '1.0').
		
	projectTwo := testRegistry newProjectNamed: 'ProjectTwo'.
	projectTwo addDependency: (CGOMetacelloConfigurationProject
		configuration: 'CargoTestExample'
		repositoryUrl: 'http://smalltalkhub.com/mc/Pharo/CargoTestRepository/main'
		version: '2.0').

	self assert: projectOne resolve hasConflicts