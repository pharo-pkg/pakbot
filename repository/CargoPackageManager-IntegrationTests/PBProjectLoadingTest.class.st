Class {
	#name : #PBProjectLoadingTest,
	#superclass : #PBAbstractTest,
	#category : #'CargoPackageManager-IntegrationTests'
}

{ #category : #private }
PBProjectLoadingTest >> performTest [
	PBPackageRegistry 
		useDefaultRegistry: testRegistry
		during: [ self perform: testSelector asSymbol ]
]

{ #category : #'tests-pakbot-dependencies' }
PBProjectLoadingTest >> testAResolvedProjectIsInstalledWhenAllPackagesToLoadAreInstalled [

	| project repository resolvedProject |

	repository := PBGitRepositoryCreator repositoryFromUrl: self pharoCounterGitUrl.
	project := repository project.
	project 
		registry: testRegistry;
		repository: repository.
	resolvedProject := project resolve.
	resolvedProject load.
	
	self assert: resolvedProject isInstalled.
]

{ #category : #'tests-pakbot-dependencies' }
PBProjectLoadingTest >> testAResolvedProjectIsNotInstalledWhenAtLeastOnePackageToLoadIsNotInstalled [

	| project repository packageCore resolvedProject |

	repository := PBGitRepositoryCreator repositoryFromUrl: self pharoCounterGitUrl.
	project := repository project.
	project 
		registry: testRegistry;
		repository: repository.
	testRegistry registerProject: project.
	
	packageCore := project packageNamed: 'Counter-Core'.
	resolvedProject := project resolve.
	
	self deny: resolvedProject isInstalled.

]

{ #category : #'tests-pakbot-dependencies' }
PBProjectLoadingTest >> testCanLoadAProjectAssembly [

	| project repository packageCore packageTest assembly |

	repository := PBGitRepositoryCreator repositoryFromUrl: self pharoCounterGitUrl.
	project := repository project.
	project 
		registry: testRegistry;
		repository: repository.
	packageCore := project packageNamed: 'Counter-Core'.
	packageTest := project packageNamed: 'Counter-Tests'.
	assembly := project addAssemblyNamed: 'Counter-Assembly'.
	assembly addPackage: packageCore.
	assembly addPackage: packageTest.
	assembly resolve load.
	
	self 
		assertCollection: project installedPackages 
		hasSameElements: { packageCore . packageTest }.
	self assert: (Smalltalk globals hasClassNamed: 'Counter').
	self assert: (Smalltalk globals hasClassNamed: 'CounterTest').
]

{ #category : #'tests-pakbot-dependencies' }
PBProjectLoadingTest >> testCanLoadAProjectPackage [

	| project packageCore repository |

	repository := PBGitRepositoryCreator repositoryFromUrl: self pharoCounterGitUrl.
	project := repository project.
	project 
		registry: testRegistry;
		repository: repository.
	packageCore := project packageNamed: 'Counter-Core'.
	packageCore resolve load.
	
	self 
		assertCollection: project installedPackages 
		hasSameElements: { packageCore }.
	self assert: (Smalltalk globals hasClassNamed: 'Counter').
	self deny: (Smalltalk globals hasClassNamed: 'CounterTest').
]

{ #category : #'tests-baseline-dependencies' }
PBProjectLoadingTest >> testLoadingProjectWithDependenciesToSameProjectButDifferentPackagesLoadBothPackages [

	| project baselineProjectPkgA baselineProjectPkgB |

	project := testRegistry newProjectNamed: 'Test'.
	baselineProjectPkgA := (PBMetacelloBaselineProjectDependency
		name: 'PakbotTestExample'
		repositoryUrl: 'git@github.com/pharo-pkg/PakbotTestExample.git'
		version: '1.0')
			loads: #('PakbotTestExample-PackageA');
			yourself.
	baselineProjectPkgB := (PBMetacelloBaselineProjectDependency
		name: 'PakbotTestExample'
		repositoryUrl: 'git@github.com/pharo-pkg/PakbotTestExample.git'
		version: '1.0')
			loads: #('PakbotTestExample-PackageB');
			yourself.

	project addDependency: baselineProjectPkgA.
	project addDependency: baselineProjectPkgB.
	project load.
	
	self assert: project isRegistered.
	self assert: (project systemPackageOrganizer includesPackageNamed: #'PakbotTestExample-PackageA').
	self assert: (project systemPackageOrganizer includesPackageNamed: #'PakbotTestExample-PackageB').
	self deny: (project systemPackageOrganizer includesPackageNamed: #'PakbotTestExample-PackageC').
	self deny: (project systemPackageOrganizer includesPackageNamed: #'PakbotTestExample-PackageD').
]

{ #category : #'tests-baseline-dependencies' }
PBProjectLoadingTest >> testLoadingProjectWithMetacelloBaselineConflictsFailsWithException [

	| project baselineProjectV1 baselineProjectV2 |

	project := testRegistry newProjectNamed: 'Test'.
	
	baselineProjectV1 := PBMetacelloBaselineProjectDependency
		name: 'PakbotTestExample'
		repositoryUrl: 'ssh://git@github.com/pharo-pkg/PakbotTestExample.git'
		version: '1.0'.

	baselineProjectV2 := PBMetacelloBaselineProjectDependency
		name: 'PakbotTestExample'
		repositoryUrl: 'git://git@github.com/pharo-pkg/PakbotTestExample.git'
		version: '2.0'.

	project addDependency: baselineProjectV1.
	project addDependency: baselineProjectV2.
	
	self should: [ project load ] raise: PBProjectHasConflictsError. 
	self assert: project resolve hasConflicts.	
]

{ #category : #'tests-configuration-dependencies' }
PBProjectLoadingTest >> testLoadingProjectWithMetacelloConfigurationConflictsFailsWithException [

	| project configurationProjectV1 configurationProjectV2 |

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
	
	self should: [ project load ] raise: PBProjectHasConflictsError. 
	self assert: project resolve hasConflicts.	
]

{ #category : #'tests-baseline-dependencies' }
PBProjectLoadingTest >> testNotLoadingMetacelloBaselineDoesNotLoadCorrespondingClassesInSystem [

	| project baselineProjectV1 |
	project := testRegistry newProjectNamed: 'Test'.
	
	baselineProjectV1 := PBMetacelloBaselineProjectDependency
		name: 'PakbotTestExample'
		repositoryUrl: 'ssh://git@github.com/pharo-pkg/PakbotTestExample.git'
		version: '1.0'.
	project addDependency: baselineProjectV1.
	
	self deny: (Smalltalk globals hasClassNamed: 'BaselineOfPakbotTestExample').
	self deny: (Smalltalk globals hasClassNamed: 'ClassInPakbotTestExamplePackageA').
	self deny: (Smalltalk globals hasClassNamed: 'ClassInPakbotTestExamplePackageB').
	self deny: (Smalltalk globals hasClassNamed: 'ClassInPakbotTestExamplePackageC').
	self deny: (Smalltalk globals hasClassNamed: 'ClassInPakbotTestExamplePackageD').
]

{ #category : #'tests-configuration-dependencies' }
PBProjectLoadingTest >> testNotLoadingMetacelloConfigurationDoesNotLoadCorrespondingClassesInSystem [

	| project configurationProject |

	project := testRegistry newProjectNamed: 'Test'.
	
	configurationProject := PBMetacelloConfigurationProjectDependency
		name: 'CargoTestExample'
		repositoryUrl: 'http://smalltalkhub.com/mc/Pharo/CargoTestRepository/main'
		version: '1.0'.
	project addDependency: configurationProject.
	
	self deny: (Smalltalk globals hasClassNamed: 'ConfigurationOfCargoTestExample').
	self deny: (Smalltalk globals hasClassNamed: 'ClassInPackageA').
	self deny: (Smalltalk globals hasClassNamed: 'ClassInPackageB').
	self deny: (Smalltalk globals hasClassNamed: 'ClassInPackageC').
	self deny: (Smalltalk globals hasClassNamed: 'ClassInPackageD').
]

{ #category : #'tests-conditional-dependencies' }
PBProjectLoadingTest >> testPackageLoadingWithConditionalPackageDoesNotLoadPackageWhenConditionUnmet [

	| assembly repository project packageCore conditionalPackage |

	repository := PBGitRepositoryCreator repositoryFromUrl: self pharoCounterGitUrl.
	project := repository project.
	project 
		registry: testRegistry;
		repository: repository.
	packageCore := project packageNamed: 'Counter-Core'.
	conditionalPackage := project packageNamed: 'Counter-Tests'.
	conditionalPackage platformRequirements: #( NON_EXISTING_PLATFORM_ATTRIBUTE ).
	assembly := project addAssemblyNamed: 'Counter-Assembly'.
	assembly addPackage: packageCore.
	assembly addPackage: conditionalPackage.
	assembly resolve load.

	self 
		assertCollection: project installedPackages 
		hasSameElements: { packageCore }.
	self assert: (Smalltalk globals hasClassNamed: 'Counter').
	self deny: (Smalltalk globals hasClassNamed: 'CounterTest').
]

{ #category : #'tests-conditional-dependencies' }
PBProjectLoadingTest >> testPackageLoadingWithConditionalPackageLoadsPackageWhenConditionMet [

	| assembly repository project packageCore conditionalPackage |

	repository := PBGitRepositoryCreator repositoryFromUrl: self pharoCounterGitUrl.
	project := repository project.
	project 
		registry: testRegistry;
		repository: repository.
	packageCore := project packageNamed: 'Counter-Core'.
	conditionalPackage := project packageNamed: 'Counter-Tests'.
	conditionalPackage platformRequirements: { PBPlatformAttributes new operatingSystem }.
	assembly := project addAssemblyNamed: 'Counter-Assembly'.
	assembly addPackage: packageCore.
	assembly addPackage: conditionalPackage.
	assembly resolve load.

	self 
		assertCollection: project installedPackages 
		hasSameElements: { packageCore . conditionalPackage }.
	self assert: (Smalltalk globals hasClassNamed: 'Counter').
	self assert: (Smalltalk globals hasClassNamed: 'CounterTest').
]

{ #category : #'tests-conditional-dependencies' }
PBProjectLoadingTest >> testProjectLoadingWithConditionalPackageDoesNotLoadPackageWhenConditionUnmet [
	| repository project packageCore conditionalPackage |

	repository := PBGitRepositoryCreator repositoryFromUrl: self pharoCounterGitUrl.
	project := repository project.
	project 
		registry: testRegistry;
		repository: repository.
	packageCore := project packageNamed: 'Counter-Core'.
	conditionalPackage := project packageNamed: 'Counter-Tests'.
	conditionalPackage platformRequirements: #( NON_EXISTING_PLATFORM_ATTRIBUTE ).
	project resolve load.

	self 
		assertCollection: project installedPackages 
		hasSameElements: { packageCore }.
	self assert: (Smalltalk globals hasClassNamed: 'Counter').
	self deny: (Smalltalk globals hasClassNamed: 'CounterTest').
]

{ #category : #'tests-conditional-dependencies' }
PBProjectLoadingTest >> testProjectLoadingWithConditionalPackageLoadsPackageWhenConditionMet [
	| repository project packageCore conditionalPackage |

	repository := PBGitRepositoryCreator repositoryFromUrl: self pharoCounterGitUrl.
	project := repository project.
	project 
		registry: testRegistry;
		repository: repository.
	packageCore := project packageNamed: 'Counter-Core'.
	conditionalPackage := project packageNamed: 'Counter-Tests'.
	conditionalPackage platformRequirements: { PBPlatformAttributes new operatingSystem }.
	project resolve load.

	self 
		assertCollection: project installedPackages 
		hasSameElements: { packageCore . conditionalPackage }.
	self assert: (Smalltalk globals hasClassNamed: 'Counter').
	self assert: (Smalltalk globals hasClassNamed: 'CounterTest').
]

{ #category : #'tests-baseline-dependencies' }
PBProjectLoadingTest >> testProjectLoadingWithIndirectMetacelloBaselineDependenciesV1LoadsCorrespondingClassesInSystem [

	| projectOne projectTwo baselineProjectV1 |

	projectOne := testRegistry newProjectNamed: 'ProjectOne'.
	projectOne addDependency: (PBPakbotProjectDependency
		named: 'ProjectTwo'
		version: '=0.1').
		
	projectTwo := testRegistry newProjectNamed: 'ProjectTwo'.
	projectTwo version: '0.1'.
	baselineProjectV1 := PBMetacelloBaselineProjectDependency
		name: 'PakbotTestExample'
		repositoryUrl: 'github://pharo-pkg/PakbotTestExample'
		version: '1.0'.
	projectTwo addDependency: baselineProjectV1.
	
	projectOne load.
	
	self assert: (Smalltalk globals hasClassNamed: 'BaselineOfPakbotTestExample').
	self assert: (Smalltalk globals hasClassNamed: 'ClassInPakbotTestExamplePackageA').
	self assert: (Smalltalk globals hasClassNamed: 'ClassInPakbotTestExamplePackageB').
	self assert: (Smalltalk globals hasClassNamed: 'ClassInPakbotTestExamplePackageC').
	self assert: (Smalltalk globals hasClassNamed: 'ClassInPakbotTestExamplePackageD').
	
	self assert: (Smalltalk globals at: 'ClassInPakbotTestExamplePackageA' asSymbol) version equals: 1.
	self assert: (Smalltalk globals at: 'ClassInPakbotTestExamplePackageB' asSymbol) version equals: 1.
	self assert: (Smalltalk globals at: 'ClassInPakbotTestExamplePackageC' asSymbol) version equals: 1.
	self assert: (Smalltalk globals at: 'ClassInPakbotTestExamplePackageD' asSymbol) version equals: 1.
]

{ #category : #'tests-baseline-dependencies' }
PBProjectLoadingTest >> testProjectLoadingWithIndirectMetacelloBaselineDependenciesV2LoadsCorrespondingClassesInSystem [

	| projectOne projectTwo baselineProjectV2 |

	projectOne := testRegistry newProjectNamed: 'ProjectOne'.
	projectOne addDependency: (PBPakbotProjectDependency
		named: 'ProjectTwo'
		version: '=0.1').
		
	projectTwo := testRegistry newProjectNamed: 'ProjectTwo'.
	projectTwo version: '0.1'.
	baselineProjectV2 := PBMetacelloBaselineProjectDependency
		name: 'PakbotTestExample'
		repositoryUrl: 'github://pharo-pkg/PakbotTestExample'
		version: '2.0'.
	projectTwo addDependency: baselineProjectV2.
	
	projectOne load.
	
	self assert: (Smalltalk globals hasClassNamed: 'BaselineOfPakbotTestExample').
	self assert: (Smalltalk globals hasClassNamed: 'ClassInPakbotTestExamplePackageA').
	self assert: (Smalltalk globals hasClassNamed: 'ClassInPakbotTestExamplePackageB').
	self assert: (Smalltalk globals hasClassNamed: 'ClassInPakbotTestExamplePackageC').
	self assert: (Smalltalk globals hasClassNamed: 'ClassInPakbotTestExamplePackageD').
	
	self assert: (Smalltalk globals at: 'ClassInPakbotTestExamplePackageA' asSymbol) version equals: 2.
	self assert: (Smalltalk globals at: 'ClassInPakbotTestExamplePackageB' asSymbol) version equals: 2.
	self assert: (Smalltalk globals at: 'ClassInPakbotTestExamplePackageC' asSymbol) version equals: 2.
	self assert: (Smalltalk globals at: 'ClassInPakbotTestExamplePackageD' asSymbol) version equals: 2.
]

{ #category : #'tests-configuration-dependencies' }
PBProjectLoadingTest >> testProjectLoadingWithIndirectMetacelloConfigurationDependenciesV1LoadsCorrespondingClassesInSystem [

	| projectOne projectTwo configurationProject |

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
	
	projectOne load.
	
	self assert: (Smalltalk globals hasClassNamed: 'ConfigurationOfCargoTestExample').
	self assert: (Smalltalk globals hasClassNamed: 'ClassInPackageA').
	self assert: (Smalltalk globals hasClassNamed: 'ClassInPackageB').
	self assert: (Smalltalk globals hasClassNamed: 'ClassInPackageC').
	self assert: (Smalltalk globals hasClassNamed: 'ClassInPackageD').
	
	self assert: (Smalltalk globals at: 'ClassInPackageA' asSymbol) version equals: 1.
	self assert: (Smalltalk globals at: 'ClassInPackageB' asSymbol) version equals: 1.
	self assert: (Smalltalk globals at: 'ClassInPackageC' asSymbol) version equals: 1.
	self assert: (Smalltalk globals at: 'ClassInPackageD' asSymbol) version equals: 1.
]

{ #category : #'tests-configuration-dependencies' }
PBProjectLoadingTest >> testProjectLoadingWithIndirectMetacelloConfigurationDependenciesV2LoadsCorrespondingClassesInSystem [

	| projectOne projectTwo configurationProject |

	projectOne := testRegistry newProjectNamed: 'ProjectOne'.
	projectOne addDependency: (PBPakbotProjectDependency
		named: 'ProjectTwo'
		version: '=0.1').
		
	projectTwo := testRegistry newProjectNamed: 'ProjectTwo'.
	projectTwo version: '0.1'.
	configurationProject := PBMetacelloConfigurationProjectDependency
		name: 'CargoTestExample'
		repositoryUrl: 'http://smalltalkhub.com/mc/Pharo/CargoTestRepository/main'
		version: '2.0'.
	projectTwo addDependency: configurationProject.
	
	projectOne load.
	
	self assert: (Smalltalk globals hasClassNamed: 'ConfigurationOfCargoTestExample').
	self assert: (Smalltalk globals hasClassNamed: 'ClassInPackageA').
	self assert: (Smalltalk globals hasClassNamed: 'ClassInPackageB').
	self assert: (Smalltalk globals hasClassNamed: 'ClassInPackageC').
	self assert: (Smalltalk globals hasClassNamed: 'ClassInPackageD').
	
	self assert: (Smalltalk globals at: 'ClassInPackageA' asSymbol) version equals: 2.
	self assert: (Smalltalk globals at: 'ClassInPackageB' asSymbol) version equals: 2.
	self assert: (Smalltalk globals at: 'ClassInPackageC' asSymbol) version equals: 2.
	self assert: (Smalltalk globals at: 'ClassInPackageD' asSymbol) version equals: 2.
]

{ #category : #'tests-baseline-dependencies' }
PBProjectLoadingTest >> testProjectLoadingWithMetacelloBaselineDependenciesV1LoadsCorrespondingClassesInSystem [

	| project baselineProjectV1 |

	project := testRegistry newProjectNamed: 'Test'.
	
	baselineProjectV1 := PBMetacelloBaselineProjectDependency
		name: 'PakbotTestExample'
		repositoryUrl: 'github://pharo-pkg/PakbotTestExample'
		version: '1.0'.

	project addDependency: baselineProjectV1.
	project load.
	
	self assert: (Smalltalk globals hasClassNamed: 'BaselineOfPakbotTestExample').
	self assert: (Smalltalk globals hasClassNamed: 'ClassInPakbotTestExamplePackageA').
	self assert: (Smalltalk globals hasClassNamed: 'ClassInPakbotTestExamplePackageB').
	self assert: (Smalltalk globals hasClassNamed: 'ClassInPakbotTestExamplePackageC').
	self assert: (Smalltalk globals hasClassNamed: 'ClassInPakbotTestExamplePackageD').
	
	self assert: (Smalltalk globals at: 'ClassInPakbotTestExamplePackageA' asSymbol) version equals: 1.
	self assert: (Smalltalk globals at: 'ClassInPakbotTestExamplePackageB' asSymbol) version equals: 1.
	self assert: (Smalltalk globals at: 'ClassInPakbotTestExamplePackageC' asSymbol) version equals: 1.
	self assert: (Smalltalk globals at: 'ClassInPakbotTestExamplePackageD' asSymbol) version equals: 1.
]

{ #category : #'tests-baseline-dependencies' }
PBProjectLoadingTest >> testProjectLoadingWithMetacelloBaselineDependenciesV2LoadsCorrespondingClassesInSystem [

	| project baselineProjectV1 |

	project := testRegistry newProjectNamed: 'Test'.
	
	baselineProjectV1 := PBMetacelloBaselineProjectDependency
		name: 'PakbotTestExample'
		repositoryUrl: 'github://pharo-pkg/PakbotTestExample'
		version: '2.0'.

	project addDependency: baselineProjectV1.
	project load.
	
	self assert: (Smalltalk globals hasClassNamed: 'BaselineOfPakbotTestExample').
	self assert: (Smalltalk globals hasClassNamed: 'ClassInPakbotTestExamplePackageA').
	self assert: (Smalltalk globals hasClassNamed: 'ClassInPakbotTestExamplePackageB').
	self assert: (Smalltalk globals hasClassNamed: 'ClassInPakbotTestExamplePackageC').
	self assert: (Smalltalk globals hasClassNamed: 'ClassInPakbotTestExamplePackageD').
	
	self assert: (Smalltalk globals at: 'ClassInPakbotTestExamplePackageA' asSymbol) version equals: 2.
	self assert: (Smalltalk globals at: 'ClassInPakbotTestExamplePackageB' asSymbol) version equals: 2.
	self assert: (Smalltalk globals at: 'ClassInPakbotTestExamplePackageC' asSymbol) version equals: 2.
	self assert: (Smalltalk globals at: 'ClassInPakbotTestExamplePackageD' asSymbol) version equals: 2.
]

{ #category : #'tests-configuration-dependencies' }
PBProjectLoadingTest >> testProjectLoadingWithMetacelloConfigurationDependenciesV1LoadsCorrespondingClassesInSystem [

	| project configurationProjectDependency |

	project := testRegistry newProjectNamed: 'Test'.
	
	configurationProjectDependency := PBMetacelloConfigurationProjectDependency
		name: 'CargoTestExample'
		repositoryUrl: 'http://smalltalkhub.com/mc/Pharo/CargoTestRepository/main'
		version: '1.0'.
	
	project addDependency: configurationProjectDependency.
	project load.
	
	self assert: (Smalltalk globals hasClassNamed: 'ConfigurationOfCargoTestExample').
	self assert: (Smalltalk globals hasClassNamed: 'ClassInPackageA').
	self assert: (Smalltalk globals hasClassNamed: 'ClassInPackageB').
	self assert: (Smalltalk globals hasClassNamed: 'ClassInPackageC').
	self assert: (Smalltalk globals hasClassNamed: 'ClassInPackageD').
	
	self assert: (Smalltalk globals at: 'ClassInPackageA' asSymbol) version equals: 1.
	self assert: (Smalltalk globals at: 'ClassInPackageB' asSymbol) version equals: 1.
	self assert: (Smalltalk globals at: 'ClassInPackageC' asSymbol) version equals: 1.
	self assert: (Smalltalk globals at: 'ClassInPackageD' asSymbol) version equals: 1.
]

{ #category : #'tests-configuration-dependencies' }
PBProjectLoadingTest >> testProjectLoadingWithMetacelloConfigurationDependenciesV2LoadsCorrespondingClassesInSystem [

	| project configurationProject |

	project := testRegistry newProjectNamed: 'Test'.
	
	configurationProject := PBMetacelloConfigurationProjectDependency
		name: 'CargoTestExample'
		repositoryUrl: 'http://smalltalkhub.com/mc/Pharo/CargoTestRepository/main'
		version: '2.0'.
	
	project addDependency: configurationProject.
	project load.
	
	self assert: (Smalltalk globals hasClassNamed: 'ConfigurationOfCargoTestExample').
	self assert: (Smalltalk globals hasClassNamed: 'ClassInPackageA').
	self assert: (Smalltalk globals hasClassNamed: 'ClassInPackageB').
	self assert: (Smalltalk globals hasClassNamed: 'ClassInPackageC').
	self assert: (Smalltalk globals hasClassNamed: 'ClassInPackageD').
	
	self assert: (Smalltalk globals at: 'ClassInPackageA' asSymbol) version equals: 2.
	self assert: (Smalltalk globals at: 'ClassInPackageB' asSymbol) version equals: 2.
	self assert: (Smalltalk globals at: 'ClassInPackageC' asSymbol) version equals: 2.
	self assert: (Smalltalk globals at: 'ClassInPackageD' asSymbol) version equals: 2.
]

{ #category : #'tests-pakbot-dependencies' }
PBProjectLoadingTest >> testProjectLoadingWithPakbotDependenciesV1LoadsCorrespondingClassesInSystem [

	| project pakbotProjectDependency |

	project := testRegistry newProjectNamed: 'Test'.
	
	pakbotProjectDependency := PBPakbotProjectDependency
		named: self pharoCounterProjectName 
		repositoryUrl: self pharoCounterGitUrl
		version: 'master'.
	
	project addDependency: pakbotProjectDependency.
	project load.
	
	self assert: (Smalltalk globals hasClassNamed: 'Counter').
	self assert: (Smalltalk globals hasClassNamed: 'CounterTest').
	
	self assert: (Smalltalk globals at: 'Counter' asSymbol) version equals: 1.
	self assert: (Smalltalk globals at: 'CounterTest' asSymbol) version equals: 1.
]

{ #category : #'tests-pakbot-dependencies' }
PBProjectLoadingTest >> testProjectLoadingWithPakbotOngoingProjectDependenciesKeepsThemLoaded [

	| projectOne projectTwo |
	
	projectOne := testRegistry newProjectNamed: 'ProjectOne'.
	projectOne addDependency: (PBPakbotProjectDependency
		named: 'ProjectTwo'
		version: '=0.1').
		
	projectTwo := testRegistry newProjectNamed: 'ProjectTwo'.
	projectTwo version: '0.1'.
	projectOne load.
	
	self assert: projectOne isRegistered.
	self assert: projectTwo isRegistered.
	self assert: projectOne isUpToDate.
]
