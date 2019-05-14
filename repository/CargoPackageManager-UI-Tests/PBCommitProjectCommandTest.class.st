"
Some tests could fail because some presenter are not garbage collected properly (weak reference?).
Is so, you can run a garbage collect to have them working again:
	3 timesRepeat: [ Smalltalk garbageCollect ]
"
Class {
	#name : #PBCommitProjectCommandTest,
	#superclass : #TestCase,
	#instVars : [
		'location',
		'projectName',
		'repository',
		'project',
		'repositoryLocation',
		'presenterToDelete'
	],
	#category : #'CargoPackageManager-UI-Tests'
}

{ #category : #running }
PBCommitProjectCommandTest >> setUp [
	super setUp.
	repositoryLocation := FileLocator temp / ('pharo-' , self class name , '-', DateAndTime now asFileNameCompatibleString).
]

{ #category : #tests }
PBCommitProjectCommandTest >> setUpExistingRepository [
	repository := PBGitRepositoryCreator new
		location: repositoryLocation;
		url: 'git@github.com:demarey/pharo-counter.git';
		createAndClone.
	project := PBProject fromRepository: repository.
	repository project:
		(PBIcebergProject
				onRepository: repository iceRepository
				project: project)
]

{ #category : #running }
PBCommitProjectCommandTest >> setUpNewRepository [
	project := PBProject named: 'test-project'.
	project registry: PBPackageRegistry new.
	
	repository := PBGitRepositoryCreator new
		location: repositoryLocation;
		createNewRepositoryNamed: project name.
	repository project: (PBIcebergProject onRepository: repository iceRepository project: project).
	
	project repository: repository.
]

{ #category : #running }
PBCommitProjectCommandTest >> tearDown [ 
	super tearDown.
	repository iceRepository forget.
	presenterToDelete ifNotNil: [ presenterToDelete delete ]
]

{ #category : #tests }
PBCommitProjectCommandTest >> testGivenAProjectWhenDeletingPackageInMetadataThenPackageIsNotRemovedFromRepository [
	| command commitBrowser visitor packageName packageModifications |
	
	self setUpExistingRepository.
	packageName := 'Counter-Tests'.
	project removePackage: (project packageNamed: packageName).
	command := PBCommitProjectCommand new
		project: project;
		yourself.
	self
		assert: IceTipCommitBrowser allInstances size isZero
		description: 'Cannot run this test if a commit windows is already open'.
		
	command execute.
	
	self
		assert: IceTipCommitBrowser allInstances size = 1
		description: 'Error: got many commit windows! Only one expected'.
	presenterToDelete := commitBrowser := IceTipCommitBrowser
		allInstances first.
	visitor := IceDiffListingVisitor new.
	commitBrowser diffPanel selectedItems
		do: [ :each | visitor visitTreeNode: each ].
		
	self assert: visitor removals isEmpty.
	packageModifications := visitor modifications.
	self assert: packageModifications size equals: 1.
	self
		assertCollection: packageModifications first oldNode path fullName
		equals: PBSourceRepository new projectMetadataFileName
]

{ #category : #tests }
PBCommitProjectCommandTest >> testGivenNewProjectAndFreshlyCreatedRepositoryThenIcebergWillCommitProjectMetadataAndPropertiesFile [
	| command commitBrowser visitor |
	self setUpNewRepository.
	command := PBCommitProjectCommand new 
		project: project;
		yourself.
		
	self
		assert: IceTipCommitBrowser allInstances size isZero
		description: 'Cannot run this test if a commit windows is already open'.
		
	command execute.
	
	self
		assert: IceTipCommitBrowser allInstances size = 1
		description: 'Error: got many commit windows! Only one expected'.
	presenterToDelete := commitBrowser := IceTipCommitBrowser allInstances first.
	
	visitor := IceDiffListingVisitor new.
	commitBrowser diffPanel selectedItems do: [ :each | visitor visitTreeNode: each ].

	self assert: visitor removals isEmpty.
	self 
		assert: visitor additions size 
		equals: 2.
	self 
		assertCollection: (visitor additions collect: [ :addition | addition path fullName ])
		 hasSameElements: { PBSourceRepository new projectMetadataFileName . IceRepositoryProperties propertiesFileName }.
]

{ #category : #tests }
PBCommitProjectCommandTest >> testGivenNewProjectAndRepositoryWhenAddingNewPackageThenIcebergWillCommitTheNewPackage [
	| command commitBrowser visitor packageName packageAdditions |
	
	self setUpNewRepository.
	packageName := 'CargoPackageManager-Utils'.
	project importPackageNamed: packageName.
	command := PBCommitProjectCommand new 
		project: project;
		yourself.		
	self
		assert: IceTipCommitBrowser allInstances size isZero
		description: 'Cannot run this test if a commit windows is already open'.
		
	command execute.
	
	self
		assert: IceTipCommitBrowser allInstances size = 1
		description: 'Error: got many commit windows! Only one expected'.
	presenterToDelete := commitBrowser := IceTipCommitBrowser allInstances first.
	
	visitor := IceDiffListingVisitor new.
	commitBrowser diffPanel selectedItems do: [ :each | visitor visitTreeNode: each ].

	self assert: visitor removals isEmpty.
	packageAdditions := visitor additions select: #isPackageDefinition.
	self 
		assert: packageAdditions size 
		equals: 1.
	self 
		assertCollection: packageAdditions first path fullName
		equals: packageName.
	

]
