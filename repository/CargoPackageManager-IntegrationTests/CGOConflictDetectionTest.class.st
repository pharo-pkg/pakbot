Class {
	#name : #CGOConflictDetectionTest,
	#superclass : #CGOAbstractTest,
	#category : 'CargoPackageManager-IntegrationTests'
}

{ #category : #tests }
CGOConflictDetectionTest >> testConflictingCargoDependencyAndInstalledMetacelloProjectHasConflict [

	<expectedFailure>
	| project testRegistry resolution configurationProjectV1 project2 configurationProjectV2 |
	testRegistry := CGOPackageRegistry new.	

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

	| testRegistry projectOne projectTwo |
	testRegistry := CGOPackageRegistry new.	
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

	| project testRegistry resolution configurationProjectV1 configurationProjectV2 |
	testRegistry := CGOPackageRegistry new.	
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

	| project testRegistry resolution configurationProjectV1 configurationProjectV2 resolutionOfV1 resolutionOfV2 |
	testRegistry := CGOPackageRegistry new.	
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

	| project testRegistry resolution configurationProjectV1 configurationProjectV2 |
	testRegistry := CGOPackageRegistry new.	
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

	| project testRegistry resolution configurationProjectV1 configurationProjectV2 v1Resolution v2Resolution |
	testRegistry := CGOPackageRegistry new.	
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
	self assert: v1Resolution conflictingDependencies size equals: 1
]

{ #category : #tests }
CGOConflictDetectionTest >> testConflictingMetacelloDependencyAndInstalledCargoProjectHasConflict [

	| project testRegistry resolution configurationProjectV1 |
	testRegistry := CGOPackageRegistry new.	
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

	| project testRegistry resolution configurationProjectV1 project2 configurationProjectV2 |
	testRegistry := CGOPackageRegistry new.	

	project := testRegistry newProjectNamed: 'Test'.
	configurationProjectV1 := PBMetacelloConfigurationProjectDependency
		name: 'CargoTestExample'
		repositoryUrl: 'http://smalltalkhub.com/mc/Pharo/CargoTestRepository/main'
		version: '1.0'.
	project addDependency: configurationProjectV1.
	project resolveAndLoad.
	
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
CGOConflictDetectionTest >> testEqualMetacelloDependenciesHasNoConflicts [

	| project testRegistry resolution configurationProjectV1 configurationProjectV2 |
	testRegistry := CGOPackageRegistry new.	
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

	| project testRegistry resolution configurationProjectV1 |
	testRegistry := CGOPackageRegistry new.	
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

	| testRegistry projectOne projectTwo |
	testRegistry := CGOPackageRegistry new.	
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

	| project testRegistry resolution configurationProjectV1 |
	testRegistry := CGOPackageRegistry new.	
	project := testRegistry newProjectNamed: 'Test'.
	
	configurationProjectV1 := PBMetacelloConfigurationProjectDependency
		name: 'CargoTestExample'
		repositoryUrl: 'http://smalltalkhub.com/mc/Pharo/CargoTestRepository/main'
		version: '1.0'.
	project addDependency: configurationProjectV1.
	resolution := project resolve.

	self deny: resolution hasConflicts
]
