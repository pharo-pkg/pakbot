Class {
	#name : #CGOPackageImportTest,
	#superclass : #TestCase,
	#instVars : [
		'project',
		'registry',
		'systemPackageOrganizer'
	],
	#category : 'CargoPackageManager-Tests-Model'
}

{ #category : #tests }
CGOPackageImportTest >> setUp [

	super setUp.
	registry := PBPackageRegistry new.
	project := PBProject named: 'test'.
	registry register: project.
	
	systemPackageOrganizer := RPackageOrganizer new.
	registry systemPackageOrganizer: systemPackageOrganizer.
]

{ #category : #tests }
CGOPackageImportTest >> testImportAlreadyImportedPackageDoesNotImportItTwice [

	| packageName |
	packageName := 'NewPackage'.
	systemPackageOrganizer createPackageNamed: packageName.
	
	project importPackageNamed: packageName.
	
	[ project importPackageNamed: packageName.
	  self fail ]
		on: CGOPackageAlreadyRegistered
		do: [ :error | "Do nothing, just go on to the next assertion" ].
	
	self assert: project packageUnits size equals: 1
]

{ #category : #tests }
CGOPackageImportTest >> testImportAlreadyImportedPackageRaisesException [

	| packageName |
	packageName := 'NewPackage'.
	systemPackageOrganizer createPackageNamed: packageName.
	
	project importPackageNamed: packageName.
	self
		should: [ project importPackageNamed: packageName ]
		raise: CGOPackageAlreadyRegistered
]

{ #category : #tests }
CGOPackageImportTest >> testImportExistingPackageInSystemSucceeds [

	| packageName |
	packageName := 'NewPackage'.
	systemPackageOrganizer createPackageNamed: packageName.
	project importPackageNamed: packageName.
	
	self assert: (project hasPackageNamed: packageName)
]

{ #category : #tests }
CGOPackageImportTest >> testImportNonExistingPackageInSystemRaisesException [

	| packageName |
	packageName := 'NewPackage'.
	project createPackageNamed: packageName.
	
	self
		should: [project createPackageNamed: packageName]
		raise: CGOSystemPackageAlreadyDefined
]
