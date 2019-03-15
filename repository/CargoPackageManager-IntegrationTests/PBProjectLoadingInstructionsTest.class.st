Class {
	#name : #PBProjectLoadingInstructionsTest,
	#superclass : #PBAbstractTest,
	#category : #'CargoPackageManager-IntegrationTests'
}

{ #category : #tests }
PBProjectLoadingInstructionsTest >> tearDown [

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
PBProjectLoadingInstructionsTest >> testProjectLoadingInstructionsDoesNotIncludeInstalledDependencies [
	| resolution projectOne projectTwoName projectTwoRegistration |
	
	projectOne := testRegistry newProjectNamed: 'ProjectOne'.
	projectTwoName := 'PakbotTestExample'.
	projectOne addDependency: (PBMetacelloBaselineProjectDependency  
			name: projectTwoName
			repositoryUrl: 'github://pharo-pkg/PakbotTestExample'
			version: #master).
	testRegistry metacelloProjectRegistry: MetacelloProjectRegistry new.
	projectTwoRegistration := (MetacelloProjectRegistration new
		projectName: projectTwoName;
		baselineProjectSpec: (Metacello new
			baseline: projectTwoName;
			repository: 'github://pharo-pkg/PakbotTestExample:master';
			record) projectSpecsFromRepositoryArg first;
		yourself).
	testRegistry metacelloProjectRegistry baselineRegistry
        at: #BaselineOf , projectTwoName
        put: projectTwoRegistration.
		
	resolution := projectOne resolve.
	self flag: 'todo: for now master is compared to the commit hash => need to use icerepository revparse: version to compare (but requires to first clone the repository)'.
	resolution conflicts anyOne resolveWithAlreadyInstalled.

	"Since the project and its dependencies are already loaded and up to date,
	the calculated load instructions should strip out all installed things and then be empty"
	self 
		assert: resolution resolvedDependencies size 
		equals: 1.
	self assert: resolution loadInstructions isEmpty
]

{ #category : #tests }
PBProjectLoadingInstructionsTest >> testProjectLoadingInstructionsWithCargoOngoingProjectHasEmptyLoadingInstructions [

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
PBProjectLoadingInstructionsTest >> testProjectLoadingInstructionsWithCargoProjectDependencyHasCargoLoadingInstruction [

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
PBProjectLoadingInstructionsTest >> testProjectLoadingInstructionsWithMetacelloBaselineProjectDependencyHasMetacelloLoadingInstruction [

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
PBProjectLoadingInstructionsTest >> testProjectLoadingInstructionsWithMetacelloConfigurationProjectDependencyHasMetacelloLoadingInstruction [

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
