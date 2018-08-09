Class {
	#name : #PBRepositoryMarriageTest,
	#superclass : #PBAbstractTest,
	#instVars : [
		'repositoryLocation',
		'project',
		'repository'
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
	
	project := testRegistry newProjectNamed: 'Empty'.
	repository := IceRepositoryCreator new
		location: self repositoryLocation;
		createNewRepositoryNamed: 'Empty'.
]

{ #category : #tests }
PBRepositoryMarriageTest >> tearDown [

	self removePackageIfExists: 'NewPackage'.
	repositoryLocation ensureDeleteAll.
	super tearDown
]

{ #category : #tests }
PBRepositoryMarriageTest >> testEmptyProjectToEmptyRepositoryDoesNotAddNewPackages [
		
	project addIcebergRepository: repository.

	self assert: project packages isEmpty.
	self assert: repository workingCopy packages isEmpty.
]

{ #category : #tests }
PBRepositoryMarriageTest >> testEmptyProjectToEmptyRepositorySetsPakbotProject [

	project addIcebergRepository: repository.

	self assert: repository workingCopy project pakbotProject equals: project.
]

{ #category : #tests }
PBRepositoryMarriageTest >> testProjectPackageIsAddedToRepository [

	| package |
	package := project createPackageNamed: 'NewPackage'.		
	project addIcebergRepository: repository.

	self assert: (repository workingCopy includesPackageNamed: package name)
]

{ #category : #tests }
PBRepositoryMarriageTest >> testRepositoryPackageIsAddedToProject [

	repository workingCopy addPackageNamed: 'NewPackage'.
	project addIcebergRepository: repository.

	self assert: (project includesPackageNamed: 'NewPackage')
]

{ #category : #tests }
PBRepositoryMarriageTest >> testRepositoryWithLoadedPackageIsAddedToProjectAsLoaded [

	| packageName |
	packageName := 'NewPackage'.
	
	"We unset the test package organizer to this test uses the global one"
	testRegistry systemPackageOrganizer: nil.
	testRegistry systemPackageOrganizer createPackageNamed: packageName.
	repository workingCopy addPackageNamed: packageName.
	
	"We ensure that the package is effectively loaded from Iceberg's point of view"
	self assert: (repository workingCopy packageNamed: packageName) isLoaded.
		
	project addIcebergRepository: repository.
	self assert: (project packageNamed: packageName) isLoaded
]

{ #category : #tests }
PBRepositoryMarriageTest >> testRepositoryWithNonLoadedPackageIsAddedToProjectAsNonLoaded [

	| packageName |
	packageName := 'NewPackage'.
	repository workingCopy addPackageNamed: packageName.
	
	"We ensure that the package is effectively not loaded from Iceberg's point of view"
	self deny: (repository workingCopy packageNamed: packageName) isLoaded.
		
	project addIcebergRepository: repository.
	self deny: (project packageNamed: packageName) isLoaded
]
