Class {
	#name : #PBConflictDetectionTest,
	#superclass : #PBAbstractTest,
	#category : #'Pakbot-IntegrationTests-Conflicts'
}

{ #category : #tests }
PBConflictDetectionTest >> testConflictingIndirectMetacelloDependenciesHasConflicts [

	| projectOne projectTwo |

	projectOne := testRegistry newProjectNamed: 'ProjectOne'.
	projectOne addDependency: (PBPakbotProjectDependency
		named: 'ProjectTwo'
		version: '0.2').
	projectOne addDependency: (PBMetacelloConfigurationProjectDependency
		name: 'CargoTestExample'
		repositoryUrl: 'http://smalltalkhub.com/mc/Pharo/CargoTestRepository/main'
		version: '1.0').
		
	projectTwo := testRegistry newProjectNamed: 'ProjectTwo'.
	projectTwo 
		version: '0.2';
		addDependency: (PBMetacelloConfigurationProjectDependency
			name: 'CargoTestExample'
			repositoryUrl: 'http://smalltalkhub.com/mc/Pharo/CargoTestRepository/main'
			version: '2.0').

	self assert: projectOne resolve hasConflicts
]

{ #category : #tests }
PBConflictDetectionTest >> testConflictingMetacelloAndCargoDependenciesThenResolvedDependenciesHaveEachOtherConflict [

	| project resolution configurationProjectV1 configurationProjectV2 resolutionOfV1 resolutionOfV2 |

	project := testRegistry newProjectNamed: 'Test'.
	(testRegistry newProjectNamed: 'CargoTestExample') version: '0.3'.
	
	configurationProjectV1 := PBMetacelloConfigurationProjectDependency
		name: 'CargoTestExample'
		repositoryUrl: 'http://smalltalkhub.com/mc/Pharo/CargoTestRepository/main'
		version: '1.0'.

	configurationProjectV2 := PBPakbotProjectDependency
		named: 'CargoTestExample'
		version: '=0.3'.

	project addDependency: configurationProjectV1.
	project addDependency: configurationProjectV2.	
	resolution := project resolve.

	resolutionOfV1 := resolution resolutionFor: configurationProjectV1.
	resolutionOfV2 := resolution resolutionFor: configurationProjectV2.
	
	self assert: (resolutionOfV1 conflictingDependencies includes: resolutionOfV2).
	self assert: (resolutionOfV2 conflictingDependencies includes: resolutionOfV1)
]

{ #category : #tests }
PBConflictDetectionTest >> testConflictingMetacelloAndPakbotDependenciesHasConflicts [

	| project resolution configurationProjectV1 configurationProjectV2 |

	project := testRegistry newProjectNamed: 'Test'.
	(testRegistry newProjectNamed: 'CargoTestExample') version: '0.3'.
	
	configurationProjectV1 := PBMetacelloConfigurationProjectDependency
		name: 'CargoTestExample'
		repositoryUrl: 'http://smalltalkhub.com/mc/Pharo/CargoTestRepository/main'
		version: '1.0'.

	configurationProjectV2 := PBPakbotProjectDependency
		named: 'CargoTestExample'
		version: '=0.3'.

	project addDependency: configurationProjectV1.
	project addDependency: configurationProjectV2.	
	resolution := project resolve.

	self assert: resolution hasConflicts
]

{ #category : #tests }
PBConflictDetectionTest >> testConflictingMetacelloDependenciesHasConflicts [

	| project resolution configurationProjectV1 configurationProjectV2 |

	project := testRegistry newProjectNamed: 'Test'.
	
	configurationProjectV1 := PBMetacelloConfigurationProjectDependency
		name: 'CargoTestExample'
		repositoryUrl: 'http://smalltalkhub.com/mc/Pharo/CargoTestRepository/main'
		version: '1.0'.

	configurationProjectV2 := PBMetacelloConfigurationProjectDependency
		name: 'CargoTestExample'
		repositoryUrl: 'http://smalltalkhub.com/mc/Pharo/CargoTestRepository/main'
		version: '2.0'.
	
	project addDependency: configurationProjectV1.
	project addDependency: configurationProjectV2.	
	resolution := project resolve.

	self assert: resolution hasConflicts
]

{ #category : #tests }
PBConflictDetectionTest >> testConflictingMetacelloDependenciesResolutionsKnowTheirConflictingPairs [

	| project resolution configurationProjectV1 configurationProjectV2 v1Resolution v2Resolution |

	project := testRegistry newProjectNamed: 'Test'.
	
	configurationProjectV1 := PBMetacelloConfigurationProjectDependency
		name: 'CargoTestExample'
		repositoryUrl: 'http://smalltalkhub.com/mc/Pharo/CargoTestRepository/main'
		version: '1.0'.

	configurationProjectV2 := PBMetacelloConfigurationProjectDependency
		name: 'CargoTestExample'
		repositoryUrl: 'http://smalltalkhub.com/mc/Pharo/CargoTestRepository/main'
		version: '2.0'.
	
	project addDependency: configurationProjectV1.
	project addDependency: configurationProjectV2.	
	resolution := project resolve.

	v1Resolution := resolution resolutionFor: configurationProjectV1.
	v2Resolution := resolution resolutionFor: configurationProjectV2.

	self assert: (v1Resolution conflictingDependencies includes: v2Resolution).
	self assert: v1Resolution conflictingDependencies size equals: 2
]

{ #category : #tests }
PBConflictDetectionTest >> testConflictingMetacelloDependencyAndInstalledMetacelloProjectHasConflict [

	| project resolution configurationProjectV1 project2 configurationProjectV2 |

	project := testRegistry newProjectNamed: 'Test'.
	configurationProjectV1 := PBMetacelloConfigurationProjectDependency
		name: 'CargoTestExample'
		repositoryUrl: 'http://smalltalkhub.com/mc/Pharo/CargoTestRepository/main'
		version: '1.0'.
	project addDependency: configurationProjectV1.
	project load.
	
	project2 := testRegistry newProjectNamed: 'Test2'.
	configurationProjectV2 := PBMetacelloConfigurationProjectDependency
		name: 'CargoTestExample'
		repositoryUrl: 'http://smalltalkhub.com/mc/Pharo/CargoTestRepository/main'
		version: '2.0'.
	project2 addDependency: configurationProjectV2.

	resolution := project2 resolve.
	self assert: resolution hasConflicts
]

{ #category : #tests }
PBConflictDetectionTest >> testConflictingMetacelloDependencyAndInstalledPakbotProjectHasConflict [

	| project resolution configurationProjectV1 |

	project := testRegistry newProjectNamed: 'Test'.
	testRegistry newProjectNamed: 'CargoTestExample'.
	
	configurationProjectV1 := PBMetacelloConfigurationProjectDependency
		name: 'CargoTestExample'
		repositoryUrl: 'http://smalltalkhub.com/mc/Pharo/CargoTestRepository/main'
		version: '1.0'.

	project addDependency: configurationProjectV1.
	resolution := project resolve.

	self assert: resolution hasConflicts
]

{ #category : #tests }
PBConflictDetectionTest >> testConflictingMetacelloDependencyWithInstalledUsingDifferentVersionInstalledIsConflict [

	| project resolution configurationProjectV1 |

	project := testRegistry newProjectNamed: 'Test'.
	
	Metacello new
		configuration: 'CargoTestExample';
		repository: 'http://smalltalkhub.com/mc/Pharo/CargoTestRepository/main';
		version: '1.0';
		load.
	
	configurationProjectV1 := PBMetacelloConfigurationProjectDependency
		name: 'CargoTestExample'
		repositoryUrl: 'http://smalltalkhub.com/mc/Pharo/CargoTestRepository/main'
		version: '2.0'.

	project addDependency: configurationProjectV1.
	resolution := project resolve.

	self assert: resolution hasConflicts
]

{ #category : #tests }
PBConflictDetectionTest >> testConflictingMetacelloDependencyWithInstalledUsingSameVersionInstalledIsNotConflict [

	| project resolution configurationProjectV1 |

	project := testRegistry newProjectNamed: 'Test'.
	
	Metacello new
		configuration: 'CargoTestExample';
		repository: 'http://smalltalkhub.com/mc/Pharo/CargoTestRepository/main';
		version: '2.0';
		load.
	
	configurationProjectV1 := PBMetacelloConfigurationProjectDependency
		name: 'CargoTestExample'
		repositoryUrl: 'http://smalltalkhub.com/mc/Pharo/CargoTestRepository/main'
		version: '2.0'.

	project addDependency: configurationProjectV1.
	resolution := project resolve.

	self deny: resolution hasConflicts
]

{ #category : #tests }
PBConflictDetectionTest >> testConflictingMetacelloDependencyWithInstalledUsingStableAndDifferentVersionInstalledIsConflict [

	| project resolution configurationProjectV1 |

	project := testRegistry newProjectNamed: 'Test'.
	
	Metacello new
		configuration: 'CargoTestExample';
		repository: 'http://smalltalkhub.com/mc/Pharo/CargoTestRepository/main';
		version: '1.0';
		load.
	
	configurationProjectV1 := PBMetacelloConfigurationProjectDependency
		name: 'CargoTestExample'
		repositoryUrl: 'http://smalltalkhub.com/mc/Pharo/CargoTestRepository/main'
		version: #stable.

	project addDependency: configurationProjectV1.
	resolution := project resolve.

	self assert: resolution hasConflicts
]

{ #category : #tests }
PBConflictDetectionTest >> testConflictingMetacelloDependencyWithInstalledUsingStableAndSameVersionInstalledIsNotConflict [

	| project resolution configurationProjectV1 |

	project := testRegistry newProjectNamed: 'Test'.
	
	Metacello new
		configuration: 'CargoTestExample';
		repository: 'http://smalltalkhub.com/mc/Pharo/CargoTestRepository/main';
		version: '2.0';
		load.
	
	configurationProjectV1 := PBMetacelloConfigurationProjectDependency
		name: 'CargoTestExample'
		repositoryUrl: 'http://smalltalkhub.com/mc/Pharo/CargoTestRepository/main'
		version: #stable.

	project addDependency: configurationProjectV1.
	resolution := project resolve.

	self deny: resolution hasConflicts
]

{ #category : #tests }
PBConflictDetectionTest >> testConflictingPakbotDependencyAndInstalledMetacelloProjectHasConflict [

	<expectedFailure>
	| project resolution configurationProjectV1 project2 configurationProjectV2 |

	project := testRegistry newProjectNamed: 'Test'.
	configurationProjectV1 := PBMetacelloConfigurationProjectDependency 
		name: 'CargoTestExample'
		repositoryUrl: 'http://smalltalkhub.com/mc/Pharo/CargoTestRepository/main'
		version: '1.0'.
	project addDependency: configurationProjectV1.
	project load.
	
	project2 := testRegistry newProjectNamed: 'Test2'.
	configurationProjectV2 := PBPakbotProjectDependency
		named: 'CargoTestExample'
		version: '=2.0.0-N/A'.
	project2 addDependency: configurationProjectV2.

	resolution := project2 resolve.
	self assert: resolution hasConflicts
]

{ #category : #tests }
PBConflictDetectionTest >> testEqualMetacelloDependenciesHasNoConflicts [

	| project resolution configurationProjectV1 configurationProjectV2 |

	project := testRegistry newProjectNamed: 'Test'.
	
	configurationProjectV1 := PBMetacelloConfigurationProjectDependency
		name: 'CargoTestExample'
		repositoryUrl: 'http://smalltalkhub.com/mc/Pharo/CargoTestRepository/main'
		version: '1.0'.

	configurationProjectV2 := PBMetacelloConfigurationProjectDependency
		name: 'CargoTestExample'
		repositoryUrl: 'http://smalltalkhub.com/mc/Pharo/CargoTestRepository/main'
		version: '1.0'.

	project addDependency: configurationProjectV1.
	project addDependency: configurationProjectV2.	
	resolution := project resolve.

	self deny: resolution hasConflicts
]

{ #category : #tests }
PBConflictDetectionTest >> testNonConflictingDependencyResolutionsHaveNoConflictingDependencies [

	| project resolution configurationProjectV1 |

	project := testRegistry newProjectNamed: 'Test'.
	
	configurationProjectV1 := PBMetacelloConfigurationProjectDependency
		name: 'CargoTestExample'
		repositoryUrl: 'http://smalltalkhub.com/mc/Pharo/CargoTestRepository/main'
		version: '1.0'.
	project addDependency: configurationProjectV1.
	resolution := project resolve.

	self assert: (resolution resolutionFor: configurationProjectV1) conflictingDependencies isEmpty.
	self deny: (resolution resolutionFor: configurationProjectV1) hasConflicts.
]

{ #category : #tests }
PBConflictDetectionTest >> testNonConflictingIndirectMetacelloDependenciesHasNoConflicts [

	| projectOne projectTwo |

	projectOne := testRegistry newProjectNamed: 'ProjectOne'.
	projectOne addDependency: (PBPakbotProjectDependency
		named: 'ProjectTwo'
		version: '=0.2').
	projectOne addDependency: (PBMetacelloConfigurationProjectDependency
		name: 'CargoTestExample'
		repositoryUrl: 'http://smalltalkhub.com/mc/Pharo/CargoTestRepository/main'
		version: '1.0').
		
	projectTwo := testRegistry newProjectNamed: 'ProjectTwo'.
	projectTwo 
		version: '0.2';
		addDependency: (PBMetacelloConfigurationProjectDependency
			name: 'CargoTestExample'
			repositoryUrl: 'http://smalltalkhub.com/mc/Pharo/CargoTestRepository/main'
			version: '1.0').

	self deny: projectOne resolve hasConflicts
]

{ #category : #tests }
PBConflictDetectionTest >> testNonConflictingMetacelloDependenciesHasNoConflicts [

	| project resolution configurationProjectV1 |

	project := testRegistry newProjectNamed: 'Test'.
	
	configurationProjectV1 := PBMetacelloConfigurationProjectDependency
		name: 'CargoTestExample'
		repositoryUrl: 'http://smalltalkhub.com/mc/Pharo/CargoTestRepository/main'
		version: '1.0'.
	project addDependency: configurationProjectV1.
	resolution := project resolve.

	self deny: resolution hasConflicts
]
