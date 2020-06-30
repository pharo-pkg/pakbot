Class {
	#name : #CGOPackageImportTest,
	#superclass : #PBAbstractTest,
	#instVars : [
		'project',
		'systemPackageOrganizer'
	],
	#category : #'CargoPackageManager-Tests-Model'
}

{ #category : #tests }
CGOPackageImportTest >> setUp [

	super setUp.
	project := testRegistry newProjectNamed: 'test'.
	project repository: PBGitMemoryRepository new.
	
	systemPackageOrganizer := RPackageOrganizer new.
	testRegistry systemPackageOrganizer: systemPackageOrganizer.
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
