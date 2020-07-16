Class {
	#name : #PBTagProjectCommandTest,
	#superclass : #PBTestCaseWithGitCredentials,
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
PBTagProjectCommandTest >> setUp [
	super setUp.
	repositoryLocation := FileLocator temp / ('pharo-' , self class name , '-', DateAndTime now asFileNameCompatibleString).
	repository := PBGitRepositoryCreator new
		location: repositoryLocation;
		url: 'https://github.com/pharo-pkg/pharo-counter.git';
		create.
]

{ #category : #running }
PBTagProjectCommandTest >> tearDown [ 
	super tearDown.
	repository iceRepository forget.
	presenterToDelete ifNotNil: [ presenterToDelete delete ]
]

{ #category : #tests }
PBTagProjectCommandTest >> testCanTagAProject [ 
	| command tagPanel tagName currentCommit tagCommit |
	
	project := PBProject fromRepository: repository.
	repository project:
		(PBIcebergProject
				onRepository: repository iceRepository
				project: project).
	currentCommit := repository headCommit.
	command := PBTagProjectCommand new
		project: project;
		yourself.
		
	presenterToDelete := tagPanel := command execute.
	tagName := 'v2'.
	tagPanel tagNameInputText text: tagName.
	tagPanel accept.

	tagCommit := repository iceRepository lookupCommit: tagName.
	self assert: tagCommit notNil.
	self
		assert: tagCommit id
		equals: currentCommit id
]

{ #category : #tests }
PBTagProjectCommandTest >> testCanTagAProjectWhoseRepositoryIsOnlyDeclared [
	"test when the repository is not yet cloned"
	| command tagPanel tagName tagCommit |
	
	project := PBProject named: 'Pharo-Counter'.
	project repository: repository.
	command := PBTagProjectCommand new
		project: project;
		yourself.
		
	presenterToDelete := tagPanel := command execute.
	tagName := 'v2'.
	tagPanel tagNameInputText text: tagName.
	tagPanel accept.

	tagCommit := repository iceRepository lookupCommit: tagName.
	self assert: tagCommit notNil.
	"Cannot assert commit id since it would imply to first clone the repository to get the current commit id"
]
