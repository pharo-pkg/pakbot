"
Class used to set up test data for Cargo projects, units and assemblies
"
Class {
	#name : #PBModelTest,
	#superclass : #PBTest,
	#instVars : [
		'ongoingProject',
		'unitTestV1',
		'unitTestV2'
	],
	#category : #'Pakbot-Tests-Model'
}

{ #category : #cleaning }
PBModelTest >> removePackageIfExists: aPackageName [

	(aPackageName asPackageIfAbsent: [ nil ]) ifNotNil: #removeFromSystem
]

{ #category : #running }
PBModelTest >> setUp [
	super setUp.
	ongoingProject := registry newProjectNamed: #'MyProject'.
	ongoingProject description: 'A simple project used for illustration.'.
	(ongoingProject newNotLoadedPackage: #UnitTest) description: 'A simple ongoing package unit.'.
	registry
		register: self unitTestV1;
		register: self unitTestV2;
		yourself.

]

{ #category : #'test data' }
PBModelTest >> unitTestV1 [
	^ unitTestV1 ifNil: [ unitTestV1 := ongoingProject newNotLoadedPackage: #Package1 ]
]

{ #category : #'test data' }
PBModelTest >> unitTestV2 [
	^ unitTestV2 ifNil: [ unitTestV2 := ongoingProject newNotLoadedPackage: #Package2]
]

{ #category : #cleaning }
PBModelTest >> unloadCounterPackages [

	#(#'Counter-Core' #'Counter-Tests') 
		do: [ :each | self removePackageIfExists: each ].
]
