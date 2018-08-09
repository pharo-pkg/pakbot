Class {
	#name : #CGOProjectLoadingInstructionsTest,
	#superclass : #PBAbstractTest,
	#category : #'CargoPackageManager-IntegrationTests'
}

{ #category : #tests }
CGOProjectLoadingInstructionsTest >> tearDown [

	| configuration metacelloRegistration |
	super tearDown.
	
	"We fetch the loaded configuration and remove it"
	configuration := Smalltalk
		at: 'ConfigurationOfCargoTestExample' asSymbol
		ifAbsent: [ ^ self ].
		
	metacelloRegistration := MetacelloProjectRegistration registry configurationRegistry at: configuration name.
	metacelloRegistration configurationProjectSpec version spec packages
		do: [ :packageSpec | self removePackageIfExists: packageSpec name ].
	MetacelloProjectRegistration registry unregisterProjectRegistration: metacelloRegistration.
	configuration package removeFromSystem.
]

{ #category : #tests }
CGOProjectLoadingInstructionsTest >> testProjectLoadingInstructionsWithCargoOngoingProjectHasEmptyLoadingInstructions [

	| resolution projectOne |
	
	projectOne := testRegistry newProjectNamed: 'ProjectOne'.
	projectOne addDependency: (PBPakbotProjectDependency
		named: 'ProjectTwo'
		version: '=0.0.0-N/A').
		
	testRegistry newProjectNamed: 'ProjectTwo'.
	resolution := projectOne resolve.

	"Since the project and its dependencies are already loaded and up to date,
	the calculated load instructions should strip out all installed things and then be empty"
	self assert: resolution loadInstructions isEmpty
]

{ #category : #tests }
CGOProjectLoadingInstructionsTest >> testProjectLoadingInstructionsWithCargoProjectDependencyHasCargoLoadingInstruction [

	| resolution projectOne dependency |
	projectOne := testRegistry newProjectNamed: 'Test'.
	
	dependency := PBPakbotProjectDependency
		named: 'Counter'
		repositoryUrl: 'git@github.com:demarey/pharo-counter.git'.
	projectOne addDependency: dependency.
	resolution := projectOne resolve.

	"Since the project and its dependencies are already loaded and up to date,
	the calculated load instructions should strip out all installed things and then be empty"
	self assert: resolution loadInstructions size equals: 1.
	self assert: (resolution loadInstructions includes: self expectedCargoResolvedProject)
]

{ #category : #tests }
CGOProjectLoadingInstructionsTest >> testProjectLoadingInstructionsWithMetacelloBaselineProjectDependencyHasMetacelloLoadingInstruction [

	| resolution projectOne baselineDependency |
	projectOne := testRegistry newProjectNamed: 'Test'.
	
	baselineDependency := PBMetacelloBaselineProjectDependency
		name: 'PakbotTestExample'
		repositoryUrl: 'git://git@github.com/pharo-pkg/PakbotTestExample.git'
		version: '0866472ddded2a8fc36d3bae23f01aecfe947dc7'.
	projectOne addDependency: baselineDependency.
	resolution := projectOne resolve.

	"Since the project and its dependencies are already loaded and up to date,
	the calculated load instructions should strip out all installed things and then be empty"
	self assert: resolution loadInstructions size equals: 1.
	self assert: (resolution loadInstructions includes: (PBMetacelloConfigurationProject fromProjectDependency: baselineDependency))
]

{ #category : #tests }
CGOProjectLoadingInstructionsTest >> testProjectLoadingInstructionsWithMetacelloConfigurationProjectDependencyHasMetacelloLoadingInstruction [

	| resolution projectOne configurationProject |
	projectOne := testRegistry newProjectNamed: 'Test'.
	
	configurationProject := PBMetacelloConfigurationProjectDependency
		name: 'CargoTestExample'
		repositoryUrl: 'http://smalltalkhub.com/mc/Pharo/CargoTestRepository/main'
		version: '1.0'.
	projectOne addDependency: configurationProject.
	resolution := projectOne resolve.

	"Since the project and its dependencies are already loaded and up to date,
	the calculated load instructions should strip out all installed things and then be empty"
	self assert: resolution loadInstructions size equals: 1.
	self assert: (resolution loadInstructions includes: (PBMetacelloConfigurationProject fromProjectDependency: configurationProject))
]
