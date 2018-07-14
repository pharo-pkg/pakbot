"
Class used to set up test data for Cargo projects, units and assemblies
"
Class {
	#name : #CGOModelTest,
	#superclass : #TestCase,
	#instVars : [
		'oldRegistry',
		'ongoingProject',
		'registry'
	],
	#category : 'CargoPackageManager-Tests-Model'
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
	oldRegistry := CGOPackageRegistry default.
	ongoingProject := CGOOngoingProject example.
	registry := CGOPackageRegistry new 
		register: ongoingProject;
		register: self unitTestV1;
		register: self unitTestV2;
		yourself.
	CGOPackageRegistry default: registry.
]

{ #category : #running }
CGOModelTest >> tearDown [
	super tearDown.
	CGOPackageRegistry default: oldRegistry
]

{ #category : #'test data' }
CGOModelTest >> unitTestV1 [
	^ CGOOngoingPackageUnit example
		package: #Package1;
		project: ongoingProject;
		yourself
]

{ #category : #'test data' }
CGOModelTest >> unitTestV2 [
	^ CGOOngoingPackageUnit example
		package: #Package2;
		project: ongoingProject;
		yourself
]
