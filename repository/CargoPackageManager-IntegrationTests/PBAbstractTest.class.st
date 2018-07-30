Class {
	#name : #PBAbstractTest,
	#superclass : #ParametrizedTestCase,
	#category : #'CargoPackageManager-IntegrationTests'
}

{ #category : #tests }
PBAbstractTest >> expectedCargoResolvedProject [

	^ (PBProject named: 'Counter')
		repository: (CGOGitRepositoryCreator repositoryFromUrl: 'git@github.com:demarey/pharo-counter.git');
		version: (SemanticVersion fromString: '0-N/A')
]

{ #category : #tests }
PBAbstractTest >> tearDown [

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
