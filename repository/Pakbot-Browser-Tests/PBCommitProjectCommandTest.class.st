Class {
	#name : #PBCommitProjectCommandTest,
	#superclass : #FileTestCase,
	#instVars : [
		'repository',
		'project',
		'repositoryLocation',
		'presenterToDelete'
	],
	#category : #'Pakbot-Browser-Tests'
}

{ #category : #running }
PBCommitProjectCommandTest >> setUp [
	super setUp.
	repositoryLocation := self newTempDirectoryReference.
]

{ #category : #tests }
PBCommitProjectCommandTest >> setUpExistingRepository [
	repository := PBGitRepositoryCreator new
		location: repositoryLocation;
		url: 'https://github.com/demarey/pharo-counter.git';
		createAndClone.
	project := PBProjectVersion fromRepository: repository.
	repository project:
		(PBIcebergProject
				onRepository: repository iceRepository
				project: project)
]

{ #category : #tests }
PBCommitProjectCommandTest >> setUpExistingRepositoryWithoutPakbotMetadata [
	repository := (PBGitRepositoryCreator new
		location: repositoryLocation;
		url: 'https://github.com/pharo-pkg/pharo-counter.git';
		version: 'metadataless';
		yourself) createAndClone.
]

{ #category : #running }
PBCommitProjectCommandTest >> setUpNewRepository [
	project := PBProjectVersion named: 'test-project'.
	project registry: PBPackageRegistry new.
	
	repository := PBGitRepositoryCreator new
		location: repositoryLocation;
		createNewRepositoryNamed: project name.
	repository project: (PBIcebergProject onRepository: repository iceRepository project: project).
	
	project repository: repository.
]

{ #category : #running }
PBCommitProjectCommandTest >> tearDown [ 
	repository ifNotNil: [ :repo | repo iceRepository forget ].
	presenterToDelete ifNotNil: [ presenterToDelete delete ].
	super tearDown.

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
		
	commitBrowser := command execute.
	
	presenterToDelete := commitBrowser.
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
PBCommitProjectCommandTest >> testGivenAProjectWhenNoPackbotMetadataThenCanCommitPackbotMetadataToRepository [
	| command commitBrowser visitor packageAdditions |
	
	self setUpExistingRepositoryWithoutPakbotMetadata.
	project := PBProjectVersion named: 'CounterWithPakbot'.
	project repository: repository.
	command := PBCommitProjectCommand new
		project: project;
		usePakbot: true;
		yourself.
		
	commitBrowser := command execute.

	presenterToDelete := commitBrowser.
	visitor := IceDiffListingVisitor new.
	commitBrowser diffPanel selectedItems
		do: [ :each | visitor visitTreeNode: each ].		
	self assert: visitor removals isEmpty.
	self assert: visitor modifications isEmpty.
	packageAdditions := visitor additions.
	self assert: packageAdditions size equals: 1.
	self
		assertCollection: packageAdditions first path fullName
		equals: PBSourceRepository new projectMetadataFileName.
]

{ #category : #tests }
PBCommitProjectCommandTest >> testGivenAProjectWhenNoPackbotMetadataThenCanCommitWithoutPackbotMetadataToRepository [
	| command commitBrowser visitor |
	
	self setUpExistingRepositoryWithoutPakbotMetadata.
	project := PBProjectVersion named: 'CounterWithPakbot'.
	project repository: repository.
	command := PBCommitProjectCommand new
		project: project;
		usePakbot: false;
		yourself.
		
	commitBrowser := command execute.

	presenterToDelete := commitBrowser.
	visitor := IceDiffListingVisitor new.
	commitBrowser diffPanel selectedItems
		do: [ :each | visitor visitTreeNode: each ].		
	self assert: visitor removals isEmpty.
	self assert: visitor modifications isEmpty.
	self assert: visitor additions isEmpty.
]

{ #category : #tests }
PBCommitProjectCommandTest >> testGivenNewProjectAndFreshlyCreatedRepositoryThenIcebergWillCommitProjectMetadataAndPropertiesFile [
	| command commitBrowser visitor |
	self setUpNewRepository.
	command := PBCommitProjectCommand new 
		project: project;
		yourself.	
			
	commitBrowser := command execute.	
		
	presenterToDelete := commitBrowser.
	visitor := IceDiffListingVisitor new.
	commitBrowser diffPanel selectedItems do: [ :each | visitor visitTreeNode: each ].
	self assert: visitor removals isEmpty.
	self 
		assert: visitor additions size 
		equals: 3.
	self 
		assertCollection: (visitor additions collect: [ :addition | addition path fullName ])
		hasSameElements: { PBSourceRepository new projectMetadataFileName . IceRepositoryProperties propertiesFileName . IceBasicProject new projectFilePath basename }.
]

{ #category : #tests }
PBCommitProjectCommandTest >> testGivenNewProjectAndRepositoryWhenAddingNewPackageThenIcebergWillCommitTheNewPackage [
	| command commitBrowser visitor packageName packageAdditions |
	
	self setUpNewRepository.
	packageName := 'Pakbot-Minimal'.
	project importPackageNamed: packageName.
	command := PBCommitProjectCommand new 
		project: project;
		yourself.		
				
	commitBrowser := command execute.
	
	presenterToDelete := commitBrowser.
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
