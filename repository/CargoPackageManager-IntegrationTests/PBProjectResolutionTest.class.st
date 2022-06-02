Class {
	#name : #PBProjectResolutionTest,
	#superclass : #PBAbstractTest,
	#category : #'CargoPackageManager-IntegrationTests'
}

{ #category : #'cargo-dependencies' }
PBProjectResolutionTest >> testProjectResolutionWithCargoDependenciesIncludesBothProjectAndDependency [

	| project resolution pakbotProject |

	project := testRegistry newProjectNamed: 'Test'.
	
	pakbotProject := PBPakbotProjectDependency
		named: self pharoCounterProjectName
		repositoryUrl: self pharoCounterGitUrl.
	
	project addDependency: pakbotProject.
	resolution := project resolve.

	self assert: (resolution includesResolvedTarget: project).
	self assert: (resolution includesResolvedTarget: self expectedPakbotResolvedProject).
]

{ #category : #'cargo-dependencies' }
PBProjectResolutionTest >> testProjectResolutionWithCargoProjectDependenciesIncludesBothProjectAndDependency [

	| resolution projectOne projectTwo |
	
	projectOne := testRegistry newProjectNamed: 'ProjectOne'.
	projectOne addDependency: (PBPakbotProjectDependency
		named: 'ProjectTwo'
		version: '=0.1').
		
	projectTwo := testRegistry newProjectNamed: 'ProjectTwo'.
	projectTwo version: '0.1'.
	resolution := projectOne resolve.
	
	self assert: (resolution includesResolvedTarget: projectOne).
	self assert: (resolution includesResolvedTarget: projectTwo).
]

{ #category : #'cargo-dependencies' }
PBProjectResolutionTest >> testProjectResolutionWithIndirectCargoDependenciesIncludesBothProjectAndDependencies [

	| projectOne projectTwo resolution pakbotProject |

	projectOne := testRegistry newProjectNamed: 'ProjectOne'.
	projectOne addDependency: (PBPakbotProjectDependency
		named: 'ProjectTwo'
		version: '=0.1').
		
	projectTwo := testRegistry newProjectNamed: 'ProjectTwo'.
	projectTwo version: '0.1'.
	pakbotProject := PBPakbotProjectDependency
		named: self pharoCounterProjectName
		repositoryUrl: self pharoCounterGitUrl.
	projectTwo addDependency: pakbotProject.
	
	resolution := projectOne resolve.

	self assert: (resolution includesResolvedTarget: projectOne).
	self assert: (resolution includesResolvedTarget: projectTwo).
	self assert: (resolution includesResolvedTarget: self expectedPakbotResolvedProject).
]

{ #category : #'baseline-dependencies' }
PBProjectResolutionTest >> testProjectResolutionWithIndirectMetacelloBaselineDependenciesIncludesBothProjectAndDependencies [

	| projectOne projectTwo resolution baselineDependency |

	projectOne := testRegistry newProjectNamed: 'ProjectOne'.
	projectOne addDependency: (PBPakbotProjectDependency
		named: 'ProjectTwo'
		version: '=0.1').
		
	projectTwo := testRegistry newProjectNamed: 'ProjectTwo'.
	projectTwo version: '0.1'.
	baselineDependency := PBMetacelloBaselineProjectDependency
		name: 'PakbotTestExample'
		repositoryUrl: 'git://git@github.com/pharo-pkg/PakbotTestExample.git'
		version: '0866472ddded2a8fc36d3bae23f01aecfe947dc7'.
	projectTwo addDependency: baselineDependency.
	
	resolution := projectOne resolve.

	self assert: (resolution includesResolvedTarget: projectOne).
	self assert: (resolution includesResolvedTarget: projectTwo).
	self assert: (resolution includesResolvedTarget: (PBMetacelloConfigurationProject fromProjectDependency: baselineDependency)).
]

{ #category : #'configuration-dependencies' }
PBProjectResolutionTest >> testProjectResolutionWithIndirectMetacelloConfigurationDependenciesIncludesBothProjectAndDependencies [

	| projectOne projectTwo resolution configurationProject |

	projectOne := testRegistry newProjectNamed: 'ProjectOne'.
	projectOne addDependency: (PBPakbotProjectDependency
		named: 'ProjectTwo'
		version: '=0.1').
		
	projectTwo := testRegistry newProjectNamed: 'ProjectTwo'.
	projectTwo version: '0.1'.
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

{ #category : #'baseline-dependencies' }
PBProjectResolutionTest >> testProjectResolutionWithMetacelloBaselineDependenciesIncludesBothProjectAndDependency [

	| project resolution baselineDependency |

	project := testRegistry newProjectNamed: 'Test'.
	
	baselineDependency := PBMetacelloBaselineProjectDependency
		name: 'PakbotTestExample'
		repositoryUrl: 'git://git@github.com/pharo-pkg/PakbotTestExample.git'
		version: '0866472ddded2a8fc36d3bae23f01aecfe947dc7'.
	
	project addDependency: baselineDependency.
	
	resolution := project resolve.

	self assert: (resolution includesResolvedTarget: project).
	self assert: (resolution includesResolvedTarget: (PBMetacelloBaselineProject fromProjectDependency: baselineDependency)).
]

{ #category : #'configuration-dependencies' }
PBProjectResolutionTest >> testProjectResolutionWithMetacelloConfigurationDependenciesIncludesBothProjectAndDependency [

	| project resolution configurationProject |

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

{ #category : #'no-dependencies' }
PBProjectResolutionTest >> testProjectWithoutDependenciesResolvesToItself [

	| project resolution |
	project := testRegistry newProjectNamed: 'Test'.
	
	resolution := testRegistry newSolver solveProject: project.

	self assert: (resolution includesResolvedTarget: project)
]

{ #category : #'cargo-dependencies' }
PBProjectResolutionTest >> testResolutionOfCargoDependencyIsResolvedDependency [

	| resolution projectOne pakbotProject |
	
	projectOne := testRegistry newProjectNamed: 'ProjectOne'.
	pakbotProject := PBPakbotProjectDependency
		named: 'Counter'
		repositoryUrl: 'git@github.com:demarey/pharo-counter.git'.
	projectOne addDependency: pakbotProject.
	resolution := projectOne resolve.

	self assert: resolution resolvedDependencies anyOne equals: (resolution resolutionFor: pakbotProject)
]

{ #category : #'baseline-dependencies' }
PBProjectResolutionTest >> testResolutionOfMetacelloBaselineDependencyIsResolvedDependency [

	| resolution projectOne baselineDependency |
	
	projectOne := testRegistry newProjectNamed: 'ProjectOne'.
	baselineDependency := PBMetacelloBaselineProjectDependency
		name: 'PakbotTestExample'
		repositoryUrl: 'git://git@github.com/pharo-pkg/PakbotTestExample.git'
		version: '0866472ddded2a8fc36d3bae23f01aecfe947dc7'.
	projectOne addDependency: baselineDependency.
	resolution := projectOne resolve.
	
	self assert: resolution resolvedDependencies anyOne equals: (resolution resolutionFor: baselineDependency)
]

{ #category : #'configuration-dependencies' }
PBProjectResolutionTest >> testResolutionOfMetacelloConfigurationDependencyIsResolvedDependency [

	| resolution projectOne configurationProject |
	
	projectOne := testRegistry newProjectNamed: 'ProjectOne'.
	configurationProject := PBMetacelloConfigurationProjectDependency 
		name: 'CargoTestExample'
		repositoryUrl: 'http://smalltalkhub.com/mc/Pharo/CargoTestRepository/main'
		version: '1.0'.
	projectOne addDependency: configurationProject.
	resolution := projectOne resolve.
	
	self assert: resolution resolvedDependencies anyOne equals: (resolution resolutionFor: configurationProject)
]

{ #category : #'no-dependencies' }
PBProjectResolutionTest >> testResolutionOfProjectIsResolutionRoot [

	| resolution projectOne |
	
	projectOne := testRegistry newProjectNamed: 'ProjectOne'.
	resolution := projectOne resolve.
	
	self assert: resolution equals: (resolution resolutionFor: projectOne)
]
