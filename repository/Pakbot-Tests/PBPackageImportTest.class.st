Class {
	#name : #PBPackageImportTest,
	#superclass : #PBTest,
	#instVars : [
		'project',
		'systemPackageOrganizer'
	],
	#category : #'Pakbot-Tests-Model'
}

{ #category : #tests }
PBPackageImportTest >> setUp [

	super setUp.
	project := registry newProjectNamed: 'test'.
	project repository: PBGitMemoryRepository new.
	
	systemPackageOrganizer := RPackageOrganizer new.
	registry systemPackageOrganizer: systemPackageOrganizer.
]

{ #category : #tests }
PBPackageImportTest >> testImportAlreadyImportedPackageDoesNotImportItTwice [

	| packageName |
	packageName := 'NewPackage'.
	systemPackageOrganizer createPackageNamed: packageName.
	
	project importPackageNamed: packageName.
	
	[ project importPackageNamed: packageName.
	  self fail ]
		on: PBPackageAlreadyRegistered
		do: [ :error | "Do nothing, just go on to the next assertion" ].
	
	self assert: project packageUnits size equals: 1
]

{ #category : #tests }
PBPackageImportTest >> testImportAlreadyImportedPackageRaisesException [

	| packageName |
	packageName := 'NewPackage'.
	systemPackageOrganizer createPackageNamed: packageName.
	
	project importPackageNamed: packageName.
	self
		should: [ project importPackageNamed: packageName ]
		raise: PBPackageAlreadyRegistered
]

{ #category : #tests }
PBPackageImportTest >> testImportExistingPackageInSystemSucceeds [

	| packageName |
	packageName := 'NewPackage'.
	systemPackageOrganizer createPackageNamed: packageName.
	project importPackageNamed: packageName.
	
	self assert: (project hasPackageNamed: packageName)
]

{ #category : #tests }
PBPackageImportTest >> testImportNonExistingPackageInSystemRaisesException [

	| packageName |
	packageName := 'NewPackage'.
	project createPackageNamed: packageName.
	
	self
		should: [project createPackageNamed: packageName]
		raise: PBSystemPackageAlreadyDefined
]
