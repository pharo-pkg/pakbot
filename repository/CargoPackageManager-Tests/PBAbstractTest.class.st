Class {
	#name : #PBAbstractTest,
	#superclass : #ParametrizedTestCase,
	#instVars : [
		'testRegistry'
	],
	#category : #'CargoPackageManager-Tests'
}

{ #category : #private }
PBAbstractTest class >> isAbstract [
	^ self name = #PBAbstractTest
]

{ #category : #tests }
PBAbstractTest >> expectedCargoResolvedProject [

	^ (PBProject named: 'Counter')
		repository: (CGOGitRepositoryCreator repositoryFromUrl: 'git@github.com:demarey/pharo-counter.git');
		version: (SemanticVersion fromString: '0-N/A')
]

{ #category : #tests }
PBAbstractTest >> removePackageIfExists: aPackageName [

	(aPackageName asPackageIfAbsent: [ nil ]) ifNotNil: #removeFromSystem
]

{ #category : #tests }
PBAbstractTest >> setUp [
	super setUp.
	testRegistry := PBPackageRegistry new
]

{ #category : #tests }
PBAbstractTest >> tearDown [

	super tearDown.
	
	testRegistry unregisterFromSystem.	
	
	IceRepository registry
		detect: [ :any | any name = 'test-project-source-properties-tonel' ]
		ifFound: [ :found | found delete ].

	self unloadMetacelloBaseline.
	self unloadMetacelloConfiguration.
	self unloadPakbotProject.
	
	(MCRepositoryGroup default repositories select: [ :each | each species = IceMetacelloRepositoryAdapter and: [ each repository name = 'PakbotTestExample' ] ]) do: #unregister
]

{ #category : #running }
PBAbstractTest >> unloadMetacelloBaseline [
	
	"We fetch the loaded configuration and remove it"
	| metacelloRegistration |

	self removePackageIfExists: 'BaselineOfPakbotTestExample'.
	self removePackageIfExists: 'PakbotTestExample-PackageA'.
	self removePackageIfExists: 'PakbotTestExample-PackageB'.
	self removePackageIfExists: 'PakbotTestExample-PackageC'.
	self removePackageIfExists: 'PakbotTestExample-PackageD'.

	IceRepository registry
		detect: [ :any | any name = 'PakbotTestExample' ]
		ifFound: [ :found | found delete ].

	metacelloRegistration := MetacelloProjectRegistration registry baselineRegistry at: 'BaselineOfPakbotTestExample' ifAbsent: [^ self].
	MetacelloProjectRegistration registry unregisterProjectRegistration: metacelloRegistration.
	

]

{ #category : #running }
PBAbstractTest >> unloadMetacelloConfiguration [
	"We fetch the loaded configuration and remove it"

	| configuration |
	configuration := Smalltalk
		at: 'ConfigurationOfCargoTestExample' asSymbol
		ifAbsent: [ ('ConfigurationOfCargoTestExample' asPackageIfAbsent: nil) ifNotNil: #removeFromSystem.
			^ self ].
	MetacelloProjectRegistration registry configurationRegistry
		at: configuration name
		ifPresent: [ :metacelloRegistration | 
			metacelloRegistration configurationProjectSpec version spec packages do: [ :packageSpec | self removePackageIfExists: packageSpec name ].
			MetacelloProjectRegistration registry unregisterProjectRegistration: metacelloRegistration ].
		
	('ConfigurationOfCargoTestExample' asPackageIfAbsent: nil) ifNotNil: #removeFromSystem
]

{ #category : #running }
PBAbstractTest >> unloadPakbotProject [
	
	#(#'Counter-Core' #'Counter-Tests') do: [ :each |
		(RPackageOrganizer default includesPackageNamed: each)
			ifTrue: [ (RPackageOrganizer default packageNamed: each) removeFromSystem ] ]
]
