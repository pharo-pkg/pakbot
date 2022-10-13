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
	#category : #'CargoPackageManager-Tests-Model'
}

{ #category : #'test data' }
PBModelTest >> project [
	^ ongoingProject asCargoProject 
		instVarNamed: 'version' put: '1' asSemanticVersion;
		yourself
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
