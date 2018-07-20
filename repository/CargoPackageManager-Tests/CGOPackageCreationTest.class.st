Class {
	#name : #CGOPackageCreationTest,
	#superclass : #TestCase,
	#instVars : [
		'project',
		'registry',
		'systemPackageOrganizer'
	],
	#category : 'CargoPackageManager-Tests-Model'
}

{ #category : #tests }
CGOPackageCreationTest >> setUp [

	super setUp.
	registry := CGOPackageRegistry new.
	project := PBProject named: 'test'.
	registry register: project.
	
	systemPackageOrganizer := RPackageOrganizer new.
	project systemPackageOrganizer: systemPackageOrganizer.
]

{ #category : #tests }
CGOPackageCreationTest >> testCreateAlreadyExistingPackageRaisesException [

	| packageName |
	packageName := 'NewPackage'.
	project createNewPackageNamed: packageName.
	
	self
		should: [project createNewPackageNamed: packageName]
		raise: CGOSystemPackageAlreadyDefined
]

{ #category : #tests }
CGOPackageCreationTest >> testCreateExistingPackageInSystemRaisesException [

	| packageName |
	packageName := 'NewPackage'.
	systemPackageOrganizer createPackageNamed: packageName.
	
	self
		should: [project createNewPackageNamed: packageName]
		raise: CGOSystemPackageAlreadyDefined
]

{ #category : #tests }
CGOPackageCreationTest >> testCreateNonExistingPackageSucceeds [

	| packageName |
	packageName := 'NewPackage'.
	project createNewPackageNamed: packageName.
	
	self assert: (project hasPackageNamed: packageName)
]
