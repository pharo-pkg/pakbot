"
Some tests could fail because some presenter are not garbage collected properly (weak reference?).
Is so, you can run a garbage collect to have them working again:
	3 timesRepeat: [ Smalltalk garbageCollect ]
"
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
		url: 'git@github.com:demarey/pharo-counter.git';
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
