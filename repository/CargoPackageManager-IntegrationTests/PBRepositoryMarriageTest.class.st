Class {
	#name : #PBRepositoryMarriageTest,
	#superclass : #PBAbstractTest,
	#instVars : [
		'repositoryLocation'
	],
	#category : #'CargoPackageManager-IntegrationTests'
}

{ #category : #tests }
PBRepositoryMarriageTest >> repositoryLocation [
	
	^ repositoryLocation
]

{ #category : #tests }
PBRepositoryMarriageTest >> setUp [

	super setUp.
	testRegistry systemPackageOrganizer: RPackageOrganizer new.
	repositoryLocation := 'pakbot-test-repository' asFileReference.
]

{ #category : #tests }
PBRepositoryMarriageTest >> tearDown [

	repositoryLocation ensureDeleteAll.
	super tearDown
]

{ #category : #tests }
PBRepositoryMarriageTest >> testEmptyProjectToEmptyRepositoryDoesNotAddNewPackages [

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
PBRepositoryMarriageTest >> testEmptyProjectToEmptyRepositorySetsPakbotProject [

	| emptyProject repository |
	emptyProject := testRegistry newProjectNamed: 'Empty'.
	
	repository := IceRepositoryCreator new
		location: self repositoryLocation;
		createNewRepositoryNamed: 'Empty'.
		
	emptyProject addIcebergRepository: repository.

	self assert: repository workingCopy project pakbotProject equals: emptyProject.
]

{ #category : #tests }
PBRepositoryMarriageTest >> testProjectPackageIsAddedToRepository [

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
PBRepositoryMarriageTest >> testRepositoryPackageIsAddedToProject [

	| emptyProject repository |
	emptyProject := testRegistry newProjectNamed: 'Empty'.
	
	repository := IceRepositoryCreator new
		location: self repositoryLocation;
		createNewRepositoryNamed: 'Empty'.
	repository workingCopy addPackageNamed: 'NewPackage'.
		
	emptyProject addIcebergRepository: repository.

	self assert: (emptyProject includesPackageNamed: 'NewPackage')
]
