Class {
	#name : #CGOProjectLoadingInstructionsTest,
	#superclass : #CGOAbstractTest,
	#category : 'CargoPackageManager-IntegrationTests'
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
		do: [ :packageSpec | | packageOrNil |
			packageOrNil := packageSpec name asPackageIfAbsent: [ nil ].
			packageOrNil ifNotNil: #removeFromSystem ].
	MetacelloProjectRegistration registry unregisterProjectRegistration: metacelloRegistration.
	configuration package removeFromSystem.
]

{ #category : #tests }
CGOProjectLoadingInstructionsTest >> testProjectLoadingInstructionsWithCargoOngoingProjectHasEmptyLoadingInstructions [

	| testRegistry resolution projectOne |
	testRegistry := CGOPackageRegistry new.
	
	projectOne := testRegistry newProjectNamed: 'ProjectOne'.
	projectOne addDependency: (CGOCargoProjectDependency
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

	| testRegistry resolution projectOne dependency |
	testRegistry := CGOPackageRegistry new.	
	projectOne := testRegistry newProjectNamed: 'Test'.
	
	dependency := CGOCargoProjectDependency
		named: 'test-project-source-properties-tonel'
		repositoryUrl: 'git@github.com:pharo-vcs/test-project-source-properties-tonel.git'.
	projectOne addDependency: dependency.
	resolution := projectOne resolve.

	"Since the project and its dependencies are already loaded and up to date,
	the calculated load instructions should strip out all installed things and then be empty"
	self assert: resolution loadInstructions size equals: 1.
	self assert: (resolution loadInstructions includes: self expectedCargoResolvedProject)
]

{ #category : #tests }
CGOProjectLoadingInstructionsTest >> testProjectLoadingInstructionsWithMetacelloProjectDependencyHasMetacelloLoadingInstruction [

	| testRegistry resolution projectOne configurationProject |
	testRegistry := CGOPackageRegistry new.	
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
