Class {
	#name : #PBPackageCreationTest,
	#superclass : #PBTest,
	#instVars : [
		'project',
		'systemPackageOrganizer'
	],
	#category : #'Pakbot-Tests-Model'
}

{ #category : #tests }
PBPackageCreationTest >> setUp [

	super setUp.
	project := registry newProjectNamed: 'test'.
	project repository: PBGitMemoryRepository new.
	
	systemPackageOrganizer := RPackageOrganizer new.
	registry systemPackageOrganizer: systemPackageOrganizer.
]

{ #category : #tests }
PBPackageCreationTest >> testCreateAlreadyExistingPackageRaisesException [

	| packageName |
	packageName := 'NewPackage'.
	project createPackageNamed: packageName.
	
	self
		should: [project createPackageNamed: packageName]
		raise: PBSystemPackageAlreadyDefined
]

{ #category : #tests }
PBPackageCreationTest >> testCreateExistingPackageInSystemRaisesException [

	| packageName |
	packageName := 'NewPackage'.
	systemPackageOrganizer createPackageNamed: packageName.
	
	self
		should: [project createPackageNamed: packageName]
		raise: PBSystemPackageAlreadyDefined
]

{ #category : #tests }
PBPackageCreationTest >> testCreateNonExistingPackageSucceeds [

	| packageName |
	packageName := 'NewPackage'.
	project createPackageNamed: packageName.
	
	self assert: (project hasPackageNamed: packageName)
]
