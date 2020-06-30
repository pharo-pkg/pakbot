Class {
	#name : #CGOPackageCreationTest,
	#superclass : #PBAbstractTest,
	#instVars : [
		'project',
		'systemPackageOrganizer'
	],
	#category : #'CargoPackageManager-Tests-Model'
}

{ #category : #tests }
CGOPackageCreationTest >> setUp [

	super setUp.
	project := testRegistry newProjectNamed: 'test'.
	project repository: PBGitMemoryRepository new.
	
	systemPackageOrganizer := RPackageOrganizer new.
	testRegistry systemPackageOrganizer: systemPackageOrganizer.
]

{ #category : #tests }
CGOPackageCreationTest >> testCreateAlreadyExistingPackageRaisesException [

	| packageName |
	packageName := 'NewPackage'.
	project createPackageNamed: packageName.
	
	self
		should: [project createPackageNamed: packageName]
		raise: CGOSystemPackageAlreadyDefined
]

{ #category : #tests }
CGOPackageCreationTest >> testCreateExistingPackageInSystemRaisesException [

	| packageName |
	packageName := 'NewPackage'.
	systemPackageOrganizer createPackageNamed: packageName.
	
	self
		should: [project createPackageNamed: packageName]
		raise: CGOSystemPackageAlreadyDefined
]

{ #category : #tests }
CGOPackageCreationTest >> testCreateNonExistingPackageSucceeds [

	| packageName |
	packageName := 'NewPackage'.
	project createPackageNamed: packageName.
	
	self assert: (project hasPackageNamed: packageName)
]
