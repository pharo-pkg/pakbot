Class {
	#name : #PBMetacelloBaselineDependencyStatusTest,
	#superclass : #PBDependencyStatusTest,
	#category : #'CargoPackageManager-IntegrationTests'
}

{ #category : #utils }
PBMetacelloBaselineDependencyStatusTest >> createProjectDependency [
	^ PBMetacelloBaselineProjectDependency
		name: 'PakbotTestExample'
		repositoryUrl: 'git://git@github.com/pharo-pkg/PakbotTestExample.git'
		version: '0866472ddded2a8fc36d3bae23f01aecfe947dc7'
]

{ #category : #utils }
PBMetacelloBaselineDependencyStatusTest >> installProject [

	Metacello new
		baseline: 'PakbotTestExample';
		repository: 'github://pharo-pkg/PakbotTestExample:0866472ddded2a8fc36d3bae23f01aecfe947dc7';
		load.

]

{ #category : #running }
PBMetacelloBaselineDependencyStatusTest >> tearDown [

	#(#'BaselineOfPakbotTestExample'
	#'PakbotTestExample-PackageA'
	#'PakbotTestExample-PackageB'
	#'PakbotTestExample-PackageC'
	#'PakbotTestExample-PackageD')
		do: [ :each | self removePackageIfExists: each ].
		
	MetacelloProjectRegistration registry baselineRegistry removeKey: 'BaselineOfPakbotTestExample' ifAbsent: [].
	
	(MCRepositoryGroup default repositories select: [ :repo | repo class = IceMetacelloRepositoryAdapter])
		detect: [ :repo | repo repository name = 'PakbotTestExample' ]
		ifFound: [ :repo | MCRepositoryGroup default removeRepository: repo ].
		
	IceRepository registry
		detect: [ :repo | repo name = 'PakbotTestExample' ]
		ifFound: [ :repo |repo forget].
	
	super tearDown.
	
]
