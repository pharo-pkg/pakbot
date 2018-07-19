Class {
	#name : #CGOProjectResolutionTest,
	#superclass : #CGOAbstractTest,
	#category : 'CargoPackageManager-IntegrationTests'
}

{ #category : #tests }
CGOProjectResolutionTest >> testProjectResolutionWithCargoDependenciesIncludesBothProjectAndDependency [

	| project testRegistry resolution pakbotProject |
	testRegistry := CGOPackageRegistry new.	
	project := testRegistry newProjectNamed: 'Test'.
	
	pakbotProject := PBPakbotProjectDependency
		named: 'Counter'
		repositoryUrl: 'git@github.com:demarey/pharo-counter.git'.
	
	project addDependency: pakbotProject.
	resolution := project resolve.

	self assert: (resolution includesResolvedTarget: project).
	self assert: (resolution includesResolvedTarget: self expectedCargoResolvedProject).
]

{ #category : #tests }
CGOProjectResolutionTest >> testProjectResolutionWithCargoOngoingProjectDependenciesIncludesBothProjectAndDependency [

	| testRegistry resolution projectOne projectTwo |
	testRegistry := CGOPackageRegistry new.	
	
	projectOne := testRegistry newProjectNamed: 'ProjectOne'.
	projectOne addDependency: (PBPakbotProjectDependency
		named: 'ProjectTwo'
		version: '=0.0.0-N/A').
		
	projectTwo := testRegistry newProjectNamed: 'ProjectTwo'.
	resolution := projectOne resolve.
	
	self assert: (resolution includesResolvedTarget: projectOne).
	self assert: (resolution includesResolvedTarget: projectTwo).
]

{ #category : #tests }
CGOProjectResolutionTest >> testProjectResolutionWithIndirectCargoDependenciesIncludesBothProjectAndDependencies [

	| projectOne projectTwo testRegistry resolution pakbotProject |
	testRegistry := CGOPackageRegistry new.	
	projectOne := testRegistry newProjectNamed: 'ProjectOne'.
	projectOne addDependency: (PBPakbotProjectDependency
		named: 'ProjectTwo'
		version: '=0.0.0-N/A').
		
	projectTwo := testRegistry newProjectNamed: 'ProjectTwo'.
	pakbotProject := PBPakbotProjectDependency
		named: 'Counter'
		repositoryUrl: 'git@github.com:demarey/pharo-counter.git'.
	projectTwo addDependency: pakbotProject.
	
	resolution := projectOne resolve.

	self assert: (resolution includesResolvedTarget: projectOne).
	self assert: (resolution includesResolvedTarget: projectTwo).
	self assert: (resolution includesResolvedTarget: self expectedCargoResolvedProject).
]

{ #category : #tests }
CGOProjectResolutionTest >> testProjectResolutionWithIndirectMetacelloDependenciesIncludesBothProjectAndDependencies [

	| projectOne projectTwo testRegistry resolution configurationProject |
	testRegistry := CGOPackageRegistry new.	
	projectOne := testRegistry newProjectNamed: 'ProjectOne'.
	projectOne addDependency: (PBPakbotProjectDependency
		named: 'ProjectTwo'
		version: '=0.0.0-N/A').
		
	projectTwo := testRegistry newProjectNamed: 'ProjectTwo'.
	configurationProject := PBMetacelloConfigurationProjectDependency 
		name: 'CargoTestExample'
		repositoryUrl: 'http://smalltalkhub.com/mc/Pharo/CargoTestRepository/main'
		version: '1.0'.
	projectTwo addDependency: configurationProject.
	
	resolution := projectOne resolve.

	self assert: (resolution includesResolvedTarget: projectOne).
	self assert: (resolution includesResolvedTarget: projectTwo).
	self assert: (resolution includesResolvedTarget: (PBMetacelloConfigurationProject fromProjectDependency: configurationProject)).
]

{ #category : #tests }
CGOProjectResolutionTest >> testProjectResolutionWithMetacelloDependenciesIncludesBothProjectAndDependency [

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
]

{ #category : #tests }
CGOProjectResolutionTest >> testProjectWithoutDependenciesResolvesToItself [

	| project testRegistry resolution |
	testRegistry := CGOPackageRegistry new.	
	project := testRegistry newProjectNamed: 'Test'.
	
	resolution := testRegistry newSolver solveProject: project.

	self assert: (resolution includesResolvedTarget: project)
]

{ #category : #tests }
CGOProjectResolutionTest >> testResolutionOfCargoDependencyIsResolvedDependency [

	| testRegistry resolution projectOne pakbotProject |
	testRegistry := CGOPackageRegistry new.	
	
	projectOne := testRegistry newProjectNamed: 'ProjectOne'.
	pakbotProject := PBPakbotProjectDependency
		named: 'Counter'
		repositoryUrl: 'git@github.com:demarey/pharo-counter.git'.
	projectOne addDependency: pakbotProject.
	resolution := projectOne resolve.

	self assert: resolution resolvedDependencies anyOne equals: (resolution resolutionFor: pakbotProject)
]

{ #category : #tests }
CGOProjectResolutionTest >> testResolutionOfProjectDependencyIsResolvedDependency [

	| testRegistry resolution projectOne configurationProject |
	testRegistry := CGOPackageRegistry new.	
	
	projectOne := testRegistry newProjectNamed: 'ProjectOne'.
	configurationProject := PBMetacelloConfigurationProjectDependency 
		name: 'CargoTestExample'
		repositoryUrl: 'http://smalltalkhub.com/mc/Pharo/CargoTestRepository/main'
		version: '1.0'.
	projectOne addDependency: configurationProject.
	resolution := projectOne resolve.
	
	self assert: resolution resolvedDependencies anyOne equals: (resolution resolutionFor: configurationProject)
]

{ #category : #tests }
CGOProjectResolutionTest >> testResolutionOfProjectIsResolutionRoot [

	| testRegistry resolution projectOne |
	testRegistry := CGOPackageRegistry new.	
	
	projectOne := testRegistry newProjectNamed: 'ProjectOne'.
	resolution := projectOne resolve.
	
	self assert: resolution equals: (resolution resolutionFor: projectOne)
]
