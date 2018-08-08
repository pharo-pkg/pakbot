Class {
	#name : #PBAbstractTest,
	#superclass : #ParametrizedTestCase,
	#instVars : [
		'testRegistry'
	],
	#category : #'CargoPackageManager-IntegrationTests'
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

	| configuration  |
	super tearDown.
	
	IceRepository registry
		detect: [ :any | any name = 'test-project-source-properties-tonel' ]
		ifFound: [ :found | found delete ].
	
	"We fetch the loaded configuration and remove it"
	configuration := Smalltalk
		at: 'ConfigurationOfCargoTestExample' asSymbol
		ifAbsent: [ ^ self ].
		
	MetacelloProjectRegistration registry configurationRegistry 
		at: configuration name 
		ifPresent: [ :metacelloRegistration |
			metacelloRegistration configurationProjectSpec version spec packages
				do: [ :packageSpec | self removePackageIfExists: packageSpec name ].
			MetacelloProjectRegistration registry unregisterProjectRegistration: metacelloRegistration	].

	configuration package mcWorkingCopy unload.
	
	testRegistry unregisterFromSystem
]
