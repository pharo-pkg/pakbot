Class {
	#name : #CGOProjectLoadingTest,
	#superclass : #CGOAbstractTest,
	#category : 'CargoPackageManager-IntegrationTests'
}

{ #category : #tests }
CGOProjectLoadingTest >> tearDown [

	super tearDown.
	self unloadMetacelloConfiguration.
	self unloadPakbotProject.
]

{ #category : #tests }
CGOProjectLoadingTest >> testLoadingProjectWithConflictsFailsWithExcetion [

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
	
	self should: [ project load ] raise: CGOProjectHasConflictsError. 
	self assert: project resolve hasConflicts.	
]

{ #category : #tests }
CGOProjectLoadingTest >> testNotLoadingProjectLoadingDoesNotLoadCorrespondingClassesInSystem [

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

{ #category : #tests }
CGOProjectLoadingTest >> testProjectLoadingWithCargoOngoingProjectDependenciesKeepsThemLoaded [

	| testRegistry projectOne projectTwo |
	testRegistry := CGOPackageRegistry new.	
	
	projectOne := testRegistry newProjectNamed: 'ProjectOne'.
	projectOne addDependency: (PBPakbotProjectDependency
		named: 'ProjectTwo'
		version: '=0.0.0-N/A').
		
	projectTwo := testRegistry newProjectNamed: 'ProjectTwo'.
	projectOne basicLoad.
	
	self assert: projectOne isLoaded.
	self assert: projectTwo isLoaded.
	self assert: projectOne isUpToDate.
]

{ #category : #tests }
CGOProjectLoadingTest >> testProjectLoadingWithIndirectMetacelloDependenciesV1LoadsCorrespondingClassesInSystem [

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

{ #category : #tests }
CGOProjectLoadingTest >> testProjectLoadingWithIndirectMetacelloDependenciesV2LoadsCorrespondingClassesInSystem [

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

{ #category : #tests }
CGOProjectLoadingTest >> testProjectLoadingWithMetacelloDependenciesV1LoadsCorrespondingClassesInSystem [

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

{ #category : #tests }
CGOProjectLoadingTest >> testProjectLoadingWithMetacelloDependenciesV2LoadsCorrespondingClassesInSystem [

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

{ #category : #tests }
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

{ #category : #tests }
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

{ #category : #tests }
CGOProjectLoadingTest >> unloadPakbotProject [
	
	#(#'Counter-Core' #'Counter-Tests') do: [ :each |
		(RPackageOrganizer default includesPackageNamed: each)
			ifTrue: [ (RPackageOrganizer default packageNamed: each) removeFromSystem ] ]
]
