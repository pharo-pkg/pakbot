Class {
	#name : #PBTagProjectCommandTest,
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
PBTagProjectCommandTest >> setUp [
	super setUp.
	repositoryLocation := FileLocator temp / ('pharo-' , self class name , '-', DateAndTime now asFileNameCompatibleString).
	repository := PBGitRepositoryCreator new
		location: repositoryLocation;
		url: 'git@github.com:pharo-pkg/pharo-counter.git';
		createAndClone.
	project := PBProject fromRepository: repository.
	repository project:
		(PBIcebergProject
				onRepository: repository iceRepository
				project: project)
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
