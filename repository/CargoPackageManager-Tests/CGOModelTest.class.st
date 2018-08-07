"
Class used to set up test data for Cargo projects, units and assemblies
"
Class {
	#name : #CGOModelTest,
	#superclass : #PBAbstractTest,
	#instVars : [
		'oldRegistry',
		'ongoingProject',
		'registry',
		'unitTestV1',
		'unitTestV2'
	],
	#category : #'CargoPackageManager-Tests-Model'
}

{ #category : #'test data' }
CGOModelTest >> project [
	^ ongoingProject asCargoProject 
		instVarNamed: 'version' put: '1' asSemanticVersion;
		yourself
]

{ #category : #running }
CGOModelTest >> setUp [
	super setUp.
	ongoingProject := testRegistry newProjectNamed: #'MyProject'.
	ongoingProject description: 'A simple project used for illustration.'.
	(ongoingProject newNotLoadedPackage: #UnitTest) description: 'A simple ongoing package unit.'.
	testRegistry
		register: self unitTestV1;
		register: self unitTestV2;
		yourself.

]

{ #category : #'test data' }
CGOModelTest >> unitTestV1 [
	^ unitTestV1 ifNil: [ unitTestV1 := ongoingProject newNotLoadedPackage: #Package1 ]
]

{ #category : #'test data' }
CGOModelTest >> unitTestV2 [
	^ unitTestV2 ifNil: [ unitTestV2 := ongoingProject newNotLoadedPackage: #Package2]
]
