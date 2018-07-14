Class {
	#name : #CGOAbstractTest,
	#superclass : #TestCase,
	#category : 'CargoPackageManager-IntegrationTests'
}

{ #category : #tests }
CGOAbstractTest >> expectedCargoResolvedProject [

	^ (CGOOngoingProject named: 'test-project-source-properties-tonel')
		repository: (CGOGitRepositoryCreator repositoryFromUrl: 'git@github.com:pharo-vcs/test-project-source-properties-tonel.git');
		version: (SemanticVersion fromString: '0-N/A')
]

{ #category : #tests }
CGOAbstractTest >> tearDown [

	| configuration metacelloRegistration |
	super tearDown.
	
	IceRepository registry
		detect: [ :any | any name = 'test-project-source-properties-tonel' ]
		ifFound: [ :found | found delete ].
	
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
