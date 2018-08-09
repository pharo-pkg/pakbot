Class {
	#name : #CGORepositoryMarriageTest,
	#superclass : #PBAbstractTest,
	#instVars : [
		'repositoryLocation'
	],
	#category : #'CargoPackageManager-IntegrationTests'
}

{ #category : #tests }
CGORepositoryMarriageTest >> repositoryLocation [
	
	^ repositoryLocation
]

{ #category : #tests }
CGORepositoryMarriageTest >> setUp [

	super setUp.
	testRegistry systemPackageOrganizer: RPackageOrganizer new.
	repositoryLocation := UUID new asString asFileReference
]

{ #category : #tests }
CGORepositoryMarriageTest >> tearDown [

	repositoryLocation ensureDeleteAll.
	super tearDown
]

{ #category : #tests }
CGORepositoryMarriageTest >> testEmptyProjectToEmptyRepositoryDoesNotAddNewPackages [

	| emptyProject repository |
	emptyProject := testRegistry newProjectNamed: 'Empty'.
	
	repository := IceRepositoryCreator new
		location: self repositoryLocation;
		createNewRepositoryNamed: 'Empty'.
		
	emptyProject addIcebergRepository: repository.

	self assert: emptyProject packages isEmpty.
	self assert: repository workingCopy packages isEmpty.
]

{ #category : #tests }
CGORepositoryMarriageTest >> testEmptyProjectToEmptyRepositorySetsPakbotProject [

	| emptyProject repository |
	emptyProject := testRegistry newProjectNamed: 'Empty'.
	
	repository := IceRepositoryCreator new
		location: self repositoryLocation;
		createNewRepositoryNamed: 'Empty'.
		
	emptyProject addIcebergRepository: repository.

	self assert: repository workingCopy project pakbotProject equals: emptyProject.
]

{ #category : #tests }
CGORepositoryMarriageTest >> testProjectPackageIsAddedToRepository [

	| emptyProject repository package |
	emptyProject := testRegistry newProjectNamed: 'Empty'.
	package := emptyProject createPackageNamed: 'NewPackage'.
	
	repository := IceRepositoryCreator new
		location: self repositoryLocation;
		createNewRepositoryNamed: 'Empty'.
		
	emptyProject addIcebergRepository: repository.

	self assert: (repository workingCopy includesPackageNamed: package name)
]

{ #category : #tests }
CGORepositoryMarriageTest >> testRepositoryPackageIsAddedToProject [

	| emptyProject repository |
	emptyProject := testRegistry newProjectNamed: 'Empty'.
	
	repository := IceRepositoryCreator new
		location: self repositoryLocation;
		createNewRepositoryNamed: 'Empty'.
	repository workingCopy addPackageNamed: 'NewPackage'.
		
	emptyProject addIcebergRepository: repository.

	self assert: (emptyProject includesPackageNamed: 'NewPackage')
]
