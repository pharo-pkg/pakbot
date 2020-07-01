Class {
	#name : #CGOConflictDetectionTest,
	#superclass : #PBAbstractTest,
	#category : #'CargoPackageManager-IntegrationTests-Conflicts'
}

{ #category : #private }
CGOConflictDetectionTest >> performTest [
	PBPackageRegistry 
		useDefaultRegistry: testRegistry
		during: [ self perform: testSelector asSymbol ]
]

{ #category : #tests }
CGOConflictDetectionTest >> testConflictingCargoDependencyAndInstalledMetacelloProjectHasConflict [

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
CGOConflictDetectionTest >> testConflictingIndirectMetacelloDependenciesHasConflicts [

	| projectOne projectTwo |

	projectOne := testRegistry newProjectNamed: 'ProjectOne'.
	projectOne addDependency: (PBPakbotProjectDependency
		named: 'ProjectTwo'
		version: '=0.0.0-N/A').
	projectOne addDependency: (PBMetacelloConfigurationProjectDependency
		name: 'CargoTestExample'
		repositoryUrl: 'http://smalltalkhub.com/mc/Pharo/CargoTestRepository/main'
		version: '1.0').
		
	projectTwo := testRegistry newProjectNamed: 'ProjectTwo'.
	projectTwo addDependency: (PBMetacelloConfigurationProjectDependency
		name: 'CargoTestExample'
		repositoryUrl: 'http://smalltalkhub.com/mc/Pharo/CargoTestRepository/main'
		version: '2.0').

	self assert: projectOne resolve hasConflicts
]

{ #category : #tests }
CGOConflictDetectionTest >> testConflictingMetacelloAndCargoDependenciesHasConflicts [

	| project resolution configurationProjectV1 configurationProjectV2 |

	project := testRegistry newProjectNamed: 'Test'.
	testRegistry newProjectNamed: 'CargoTestExample'.
	
	configurationProjectV1 := PBMetacelloConfigurationProjectDependency
		name: 'CargoTestExample'
		repositoryUrl: 'http://smalltalkhub.com/mc/Pharo/CargoTestRepository/main'
		version: '1.0'.

	configurationProjectV2 := PBPakbotProjectDependency
		named: 'CargoTestExample'
		version: '=0.0.0-N/A'.

	project addDependency: configurationProjectV1.
	project addDependency: configurationProjectV2.	
	resolution := project resolve.

	self assert: resolution hasConflicts
]

{ #category : #tests }
CGOConflictDetectionTest >> testConflictingMetacelloAndCargoDependenciesThenResolvedDependenciesHaveEachOtherConflict [

	| project resolution configurationProjectV1 configurationProjectV2 resolutionOfV1 resolutionOfV2 |

	project := testRegistry newProjectNamed: 'Test'.
	testRegistry newProjectNamed: 'CargoTestExample'.
	
	configurationProjectV1 := PBMetacelloConfigurationProjectDependency
		name: 'CargoTestExample'
		repositoryUrl: 'http://smalltalkhub.com/mc/Pharo/CargoTestRepository/main'
		version: '1.0'.

	configurationProjectV2 := PBPakbotProjectDependency
		named: 'CargoTestExample'
		version: '=0.0.0-N/A'.

	project addDependency: configurationProjectV1.
	project addDependency: configurationProjectV2.	
	resolution := project resolve.

	resolutionOfV1 := resolution resolutionFor: configurationProjectV1.
	resolutionOfV2 := resolution resolutionFor: configurationProjectV2.
	
	self assert: (resolutionOfV1 conflictingDependencies includes: resolutionOfV2).
	self assert: (resolutionOfV2 conflictingDependencies includes: resolutionOfV1)
]

{ #category : #tests }
CGOConflictDetectionTest >> testConflictingMetacelloDependenciesHasConflicts [

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
CGOConflictDetectionTest >> testConflictingMetacelloDependenciesResolutionsKnowTheirConflictingPairs [

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
CGOConflictDetectionTest >> testConflictingMetacelloDependencyAndInstalledCargoProjectHasConflict [

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
CGOConflictDetectionTest >> testConflictingMetacelloDependencyAndInstalledMetacelloProjectHasConflict [

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
CGOConflictDetectionTest >> testConflictingMetacelloDependencyWithInstalledUsingDifferentVersionInstalledIsConflict [

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
CGOConflictDetectionTest >> testConflictingMetacelloDependencyWithInstalledUsingSameVersionInstalledIsNotConflict [

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
CGOConflictDetectionTest >> testConflictingMetacelloDependencyWithInstalledUsingStableAndDifferentVersionInstalledIsConflict [

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
CGOConflictDetectionTest >> testConflictingMetacelloDependencyWithInstalledUsingStableAndSameVersionInstalledIsNotConflict [

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
CGOConflictDetectionTest >> testEqualMetacelloDependenciesHasNoConflicts [

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
CGOConflictDetectionTest >> testNonConflictingDependencyResolutionsHaveNoConflictingDependencies [

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
CGOConflictDetectionTest >> testNonConflictingIndirectMetacelloDependenciesHasNoConflicts [

	| projectOne projectTwo |

	projectOne := testRegistry newProjectNamed: 'ProjectOne'.
	projectOne addDependency: (PBPakbotProjectDependency
		named: 'ProjectTwo'
		version: '=0.0.0-N/A').
	projectOne addDependency: (PBMetacelloConfigurationProjectDependency
		name: 'CargoTestExample'
		repositoryUrl: 'http://smalltalkhub.com/mc/Pharo/CargoTestRepository/main'
		version: '1.0').
		
	projectTwo := testRegistry newProjectNamed: 'ProjectTwo'.
	projectTwo addDependency: (PBMetacelloConfigurationProjectDependency
		name: 'CargoTestExample'
		repositoryUrl: 'http://smalltalkhub.com/mc/Pharo/CargoTestRepository/main'
		version: '1.0').

	self deny: projectOne resolve hasConflicts
]

{ #category : #tests }
CGOConflictDetectionTest >> testNonConflictingMetacelloDependenciesHasNoConflicts [

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
