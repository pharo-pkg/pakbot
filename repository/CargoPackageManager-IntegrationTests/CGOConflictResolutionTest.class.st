Class {
	#name : #CGOConflictResolutionTest,
	#superclass : #PBAbstractTest,
	#category : #'CargoPackageManager-IntegrationTests-Conflicts'
}

{ #category : #private }
CGOConflictResolutionTest >> performTest [
	PBPackageRegistry 
		useDefaultRegistry: testRegistry
		during: [ self perform: testSelector asSymbol ]
]

{ #category : #tests }
CGOConflictResolutionTest >> testConflictingMetacelloDependenciesCanBeResolvedUsingAVersion [

	| projectOne dep2 dep1 conflict solution resolution |

	dep2 := PBMetacelloConfigurationProjectDependency
		name: 'CargoTestExample'
		repositoryUrl: 'http://smalltalkhub.com/mc/Pharo/CargoTestRepository/main'
		version: '2.0'.

	dep1 := PBMetacelloConfigurationProjectDependency
		name: 'CargoTestExample'
		repositoryUrl: 'http://smalltalkhub.com/mc/Pharo/CargoTestRepository/main'
		version: '1.0'.

	projectOne := testRegistry newProjectNamed: 'ProjectOne'.
	projectOne addDependency: dep1.		
	projectOne addDependency: dep2.

	[ projectOne load. self fail. ] on: PBProjectHasConflictsError 
		do: [ :ex | 
			resolution := ex resolution.
			conflict := ex conflicts anyOne ].

	solution := conflict possibleResolutions detect: [ :aResolution | aResolution resolvedProjectVersion version = '1.0' ].
	conflict selectedResolution: solution.
	conflict resolveWithSelected.
	
	self deny: resolution hasConflicts.
	self assert: resolution loadInstructions size equals:1.
	self assert: resolution loadInstructions groups anyOne loadableUnits size equals:1 .
	self assert: (resolution loadInstructions groups anyOne loadableUnits allSatisfy: [ :e | e version = '1.0' ]).
	
	

]

{ #category : #tests }
CGOConflictResolutionTest >> testConflictingMetacelloDependenciesCanBeResolvedUsingAnotherVersion [

	| projectOne dep2 dep1 conflict solution resolution |

	dep2 := PBMetacelloConfigurationProjectDependency
		name: 'CargoTestExample'
		repositoryUrl: 'http://smalltalkhub.com/mc/Pharo/CargoTestRepository/main'
		version: '2.0'.

	dep1 := PBMetacelloConfigurationProjectDependency
		name: 'CargoTestExample'
		repositoryUrl: 'http://smalltalkhub.com/mc/Pharo/CargoTestRepository/main'
		version: '1.0'.

	projectOne := testRegistry newProjectNamed: 'ProjectOne'.
	projectOne addDependency: dep1.		
	projectOne addDependency: dep2.

	[ projectOne load. self fail. ] on: PBProjectHasConflictsError 
		do: [ :ex | 
			resolution := ex resolution.
			conflict := ex conflicts anyOne ].

	solution := conflict possibleResolutions detect: [ :aResolution | aResolution resolvedProjectVersion version = '2.0' ].
	conflict selectedResolution: solution.
	conflict resolveWithSelected.
	
	self deny: resolution hasConflicts.
	self assert: resolution loadInstructions size equals:1.
	self assert: resolution loadInstructions groups anyOne loadableUnits size equals:1 .
	self assert: (resolution loadInstructions groups anyOne loadableUnits allSatisfy: [ :e | e version = '2.0' ]).
	
	

]

{ #category : #tests }
CGOConflictResolutionTest >> testConflictingMetacelloDependenciesExceptionHasConflicts [

	| projectOne |

	projectOne := testRegistry newProjectNamed: 'ProjectOne'.
	projectOne addDependency: (PBMetacelloConfigurationProjectDependency
		name: 'CargoTestExample'
		repositoryUrl: 'http://smalltalkhub.com/mc/Pharo/CargoTestRepository/main'
		version: '1.0').		
	projectOne addDependency: (PBMetacelloConfigurationProjectDependency
		name: 'CargoTestExample'
		repositoryUrl: 'http://smalltalkhub.com/mc/Pharo/CargoTestRepository/main'
		version: '2.0').

	[ projectOne load. self fail ] on: PBProjectHasConflictsError 
	do: [ :ex | self assert: ex conflicts isNotEmpty ]

]

{ #category : #tests }
CGOConflictResolutionTest >> testConflictingMetacelloDependenciesExceptionHasOneConflictForTheDependency [

	| projectOne dep2 dep1 |

	dep2 := PBMetacelloConfigurationProjectDependency
		name: 'CargoTestExample'
		repositoryUrl: 'http://smalltalkhub.com/mc/Pharo/CargoTestRepository/main'
		version: '2.0'.

	dep1 := PBMetacelloConfigurationProjectDependency
		name: 'CargoTestExample'
		repositoryUrl: 'http://smalltalkhub.com/mc/Pharo/CargoTestRepository/main'
		version: '1.0'.

	projectOne := testRegistry newProjectNamed: 'ProjectOne'.
	projectOne addDependency: dep1.		
	projectOne addDependency: dep2.

	[ projectOne load.
	  self fail. ] on: PBProjectHasConflictsError 
		do: [ :ex | 
			self assert: ex conflicts size equals: 1.
			self assertCollection: (ex conflicts anyOne dependencies collect: #dependency) hasSameElements: { dep1. dep2 }
		]

]

{ #category : #tests }
CGOConflictResolutionTest >> testConflictingMetacelloDependenciesThrowsException [

	| projectOne |

	projectOne := testRegistry newProjectNamed: 'ProjectOne'.
	projectOne addDependency: (PBMetacelloConfigurationProjectDependency
		name: 'CargoTestExample'
		repositoryUrl: 'http://smalltalkhub.com/mc/Pharo/CargoTestRepository/main'
		version: '1.0').		
	projectOne addDependency: (PBMetacelloConfigurationProjectDependency
		name: 'CargoTestExample'
		repositoryUrl: 'http://smalltalkhub.com/mc/Pharo/CargoTestRepository/main'
		version: '2.0').

	self should: [ projectOne load ] raise: PBProjectHasConflictsError 
]

{ #category : #tests }
CGOConflictResolutionTest >> testConflictingMetacelloDependencyWithInstalledUsingDifferentVersionHasBothVersions [

	| project configurationProjectV1 |

	project := testRegistry newProjectNamed: 'Test'.
	
	Metacello new
		configuration: 'CargoTestExample';
		repository: 'http://smalltalkhub.com/mc/Pharo/CargoTestRepository/main';
		version: '2.0';
		load.

	configurationProjectV1 := PBMetacelloConfigurationProjectDependency
		name: 'CargoTestExample'
		repositoryUrl: 'http://smalltalkhub.com/mc/Pharo/CargoTestRepository/main'
		version: '1.0'.
	
	project addDependency: configurationProjectV1.

	[ project load. self fail ] on: PBProjectHasConflictsError 
		do: [ :ex | 
			self assert: ex conflicts size equals: 1.
			self assertCollection: (ex conflicts anyOne dependencies collect: [ :each | each resolution version ])	hasSameElements: { '1.0'. '2.0' }
		]

]

{ #category : #tests }
CGOConflictResolutionTest >> testConflictingMetacelloDependencyWithInstalledUsingDifferentVersionResolvedWithInstalledDoesNotInstallNothing [

	| project configurationProjectV1 resolution conflict solution |

	project := testRegistry newProjectNamed: 'Test'.
	
	Metacello new
		configuration: 'CargoTestExample';
		repository: 'http://smalltalkhub.com/mc/Pharo/CargoTestRepository/main';
		version: '2.0';
		load.

	configurationProjectV1 := PBMetacelloConfigurationProjectDependency
		name: 'CargoTestExample'
		repositoryUrl: 'http://smalltalkhub.com/mc/Pharo/CargoTestRepository/main'
		version: '1.0'.
	
	project addDependency: configurationProjectV1.

	[ project load. self fail ] on: PBProjectHasConflictsError 
		do: [ :ex | 
			resolution := ex resolution.
			conflict := ex conflicts anyOne ].
		
	solution := conflict possibleResolutions detect: [ :aResolution | aResolution resolvedProjectVersion version = '2.0' ].
	conflict selectedResolution: solution.
	conflict resolveWithSelected.
	
	self deny: resolution hasConflicts.
	self assert: resolution loadInstructions isEmpty.
		

]
