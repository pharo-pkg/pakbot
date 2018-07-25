Class {
	#name : #CGOProjectLoadingTest,
	#superclass : #CGOAbstractTest,
	#category : 'CargoPackageManager-IntegrationTests'
}

{ #category : #running }
CGOProjectLoadingTest >> tearDown [

	super tearDown.
	self unloadMetacelloConfiguration.
	self unloadMetacelloBaseline.
	self unloadPakbotProject.
]

{ #category : #'tests-baseline-dependencies' }
CGOProjectLoadingTest >> testLoadingProjectWithMetacelloBaselineConflictsFailsWithExcetion [

	| testRegistry project baselineProjectV1 baselineProjectV2 |
	testRegistry := CGOPackageRegistry new.	
	project := testRegistry newProjectNamed: 'Test'.
	
	baselineProjectV1 := PBMetacelloBaselineProjectDependency
		name: 'PakbotTestExample'
		repositoryUrl: 'git://git@github.com/pharo-pkg/PakbotTestExample.git'
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
CGOProjectLoadingTest >> testLoadingProjectWithMetacelloConfigurationConflictsFailsWithExcetion [

	| testRegistry project configurationProjectV1 configurationProjectV2 |
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
	
	self should: [ project load ] raise: PBProjectHasConflictsError. 
	self assert: project resolve hasConflicts.	
]

{ #category : #'tests-baseline-dependencies' }
CGOProjectLoadingTest >> testNotLoadingMetacelloBaselineDoesNotLoadCorrespondingClassesInSystem [

	| project testRegistry baselineProjectV1 |
	testRegistry := CGOPackageRegistry new.	
	project := testRegistry newProjectNamed: 'Test'.
	
	baselineProjectV1 := PBMetacelloBaselineProjectDependency
		name: 'PakbotTestExample'
		repositoryUrl: 'git://git@github.com/pharo-pkg/PakbotTestExample.git'
		version: '1.0'.
	project addDependency: baselineProjectV1.
	
	self deny: (Smalltalk globals hasClassNamed: 'BaselineOfPakbotTestExample').
	self deny: (Smalltalk globals hasClassNamed: 'ClassInPakbotTestExamplePackageA').
	self deny: (Smalltalk globals hasClassNamed: 'ClassInPakbotTestExamplePackageB').
	self deny: (Smalltalk globals hasClassNamed: 'ClassInPakbotTestExamplePackageC').
	self deny: (Smalltalk globals hasClassNamed: 'ClassInPakbotTestExamplePackageD').
]

{ #category : #'tests-configuration-dependencies' }
CGOProjectLoadingTest >> testNotLoadingMetacelloConfigurationDoesNotLoadCorrespondingClassesInSystem [

	| project testRegistry configurationProject |
	testRegistry := CGOPackageRegistry new.	
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

{ #category : #'tests-cargo-dependencies' }
CGOProjectLoadingTest >> testProjectLoadingWithCargoOngoingProjectDependenciesKeepsThemLoaded [

	| testRegistry projectOne projectTwo |
	testRegistry := CGOPackageRegistry new.	
	
	projectOne := testRegistry newProjectNamed: 'ProjectOne'.
	projectOne addDependency: (PBPakbotProjectDependency
		named: 'ProjectTwo'
		version: '=0.0.0-N/A').
		
	projectTwo := testRegistry newProjectNamed: 'ProjectTwo'.
	projectOne load.
	
	self assert: projectOne isLoaded.
	self assert: projectTwo isLoaded.
	self assert: projectOne isUpToDate.
]

{ #category : #'tests-baseline-dependencies' }
CGOProjectLoadingTest >> testProjectLoadingWithIndirectMetacelloBaselineDependenciesV1LoadsCorrespondingClassesInSystem [

	| projectOne projectTwo testRegistry baselineProjectV1 |
	testRegistry := CGOPackageRegistry new.	
	projectOne := testRegistry newProjectNamed: 'ProjectOne'.
	projectOne addDependency: (PBPakbotProjectDependency
		named: 'ProjectTwo'
		version: '=0.0.0-N/A').
		
	projectTwo := testRegistry newProjectNamed: 'ProjectTwo'.
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
CGOProjectLoadingTest >> testProjectLoadingWithIndirectMetacelloBaselineDependenciesV2LoadsCorrespondingClassesInSystem [

	| projectOne projectTwo testRegistry baselineProjectV2 |
	testRegistry := CGOPackageRegistry new.	
	projectOne := testRegistry newProjectNamed: 'ProjectOne'.
	projectOne addDependency: (PBPakbotProjectDependency
		named: 'ProjectTwo'
		version: '=0.0.0-N/A').
		
	projectTwo := testRegistry newProjectNamed: 'ProjectTwo'.
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
CGOProjectLoadingTest >> testProjectLoadingWithIndirectMetacelloConfigurationDependenciesV1LoadsCorrespondingClassesInSystem [

	| projectOne projectTwo testRegistry configurationProject |
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
CGOProjectLoadingTest >> testProjectLoadingWithIndirectMetacelloConfigurationDependenciesV2LoadsCorrespondingClassesInSystem [

	| projectOne projectTwo testRegistry configurationProject |
	testRegistry := CGOPackageRegistry new.	
	projectOne := testRegistry newProjectNamed: 'ProjectOne'.
	projectOne addDependency: (PBPakbotProjectDependency
		named: 'ProjectTwo'
		version: '=0.0.0-N/A').
		
	projectTwo := testRegistry newProjectNamed: 'ProjectTwo'.
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
CGOProjectLoadingTest >> testProjectLoadingWithMetacelloBaselineDependenciesV1LoadsCorrespondingClassesInSystem [

	| project testRegistry baselineProjectV1 |
	testRegistry := CGOPackageRegistry new.	
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
CGOProjectLoadingTest >> testProjectLoadingWithMetacelloBaselineDependenciesV2LoadsCorrespondingClassesInSystem [

	| project testRegistry baselineProjectV1 |
	testRegistry := CGOPackageRegistry new.	
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
CGOProjectLoadingTest >> testProjectLoadingWithMetacelloConfigurationDependenciesV1LoadsCorrespondingClassesInSystem [

	| project testRegistry configurationProjectDependency |
	testRegistry := CGOPackageRegistry new.	
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
CGOProjectLoadingTest >> testProjectLoadingWithMetacelloConfigurationDependenciesV2LoadsCorrespondingClassesInSystem [

	| project testRegistry configurationProject |
	testRegistry := CGOPackageRegistry new.	
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

{ #category : #'tests-cargo-dependencies' }
CGOProjectLoadingTest >> testProjectLoadingWithPakbotDependenciesV1LoadsCorrespondingClassesInSystem [

	| project testRegistry pakbotProjectDependency |
	testRegistry := CGOPackageRegistry new.	
	project := testRegistry newProjectNamed: 'Test'.
	
	pakbotProjectDependency := PBPakbotProjectDependency
		named: #Counter 
		repositoryUrl: 'git@github.com:demarey/pharo-counter.git'
		version: 'master'.
	
	project addDependency: pakbotProjectDependency.
	project load.
	
	self assert: (Smalltalk globals hasClassNamed: 'Counter').
	self assert: (Smalltalk globals hasClassNamed: 'CounterTest').
	
	self assert: (Smalltalk globals at: 'Counter' asSymbol) version equals: 1.
	self assert: (Smalltalk globals at: 'CounterTest' asSymbol) version equals: 1.
]

{ #category : #running }
CGOProjectLoadingTest >> unloadMetacelloBaseline [
	
	"We fetch the loaded configuration and remove it"
	| baseline metacelloRegistration |
	baseline := Smalltalk
		at: 'BaselineOfPakbotTestExample' asSymbol
		ifAbsent: [ ^ self ].

	metacelloRegistration := MetacelloProjectRegistration registry baselineRegistry at: baseline name.
	metacelloRegistration baselineProjectSpec version spec packages
		do: [ :packageSpec | | packageOrNil |
			packageOrNil := packageSpec name asPackageIfAbsent: [ nil ].
			packageOrNil ifNotNil: #removeFromSystem ].
	MetacelloProjectRegistration registry unregisterProjectRegistration: metacelloRegistration.
	baseline package removeFromSystem.
	
	IceRepository registry
		detect: [ :any | any name = 'PakbotTestExample' ]
		ifFound: [ :found | found delete ].
]

{ #category : #running }
CGOProjectLoadingTest >> unloadMetacelloConfiguration [
	
	"We fetch the loaded configuration and remove it"
	| configuration metacelloRegistration |
	configuration := Smalltalk
		at: 'ConfigurationOfCargoTestExample' asSymbol
		ifAbsent: [ ^ self ].
		
	metacelloRegistration := MetacelloProjectRegistration registry configurationRegistry at: configuration name.
	metacelloRegistration configurationProjectSpec version spec packages
		do: [ :packageSpec | | packageOrNil |
			packageOrNil := packageSpec name asPackageIfAbsent: [ nil ].
			packageOrNil ifNotNil: #removeFromSystem ].
	MetacelloProjectRegistration registry unregisterProjectRegistration: metacelloRegistration.
	configuration package removeFromSystem.
]

{ #category : #running }
CGOProjectLoadingTest >> unloadPakbotProject [
	
	#(#'Counter-Core' #'Counter-Tests') do: [ :each |
		(RPackageOrganizer default includesPackageNamed: each)
			ifTrue: [ (RPackageOrganizer default packageNamed: each) removeFromSystem ] ]
]
