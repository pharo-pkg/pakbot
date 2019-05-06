Class {
	#name : #PBImportProjectPanelTest,
	#superclass : #PBAbstractTest,
	#instVars : [
		'project',
		'panel',
		'name',
		'url',
		'version',
		'description',
		'importPanel',
		'defaultRegistry'
	],
	#category : #'CargoPackageManager-UI-Tests'
}

{ #category : #tests }
PBImportProjectPanelTest >> setUp [
	super setUp.
	
	defaultRegistry := PBPackageRegistry default.
	PBPackageRegistry default: testRegistry.
		
	importPanel := PBImportProjectFromGitPanel new.
	importPanel iceErrorVisitor: IceErrorVisitorForTests new.
		
	name := #'PharoCounter'.
	url := 'git@github.com:pharo-pkg/Pharo-Counter.git'.
	description := 'A simple counter project. You can increment it, decrement it and get the value from the counter.'
]

{ #category : #tests }
PBImportProjectPanelTest >> tearDown [ 
	super tearDown.
	
	PBPackageRegistry default: defaultRegistry.
]

{ #category : #tests }
PBImportProjectPanelTest >> testCloneErrorIsCaptured [

	url := 'git@github.com:pharo-pkg/unexisting-repo.git'.
	importPanel repositoryUrlInputText text: url.
	
	self 
		shouldnt: [ importPanel accept ]
		raise: IceCloneError.
	
	self assert: project isNil description: 'Expected nil project'.
]

{ #category : #tests }
PBImportProjectPanelTest >> testProjectIsFilledAfterAccept [

	version := ''.
	importPanel repositoryUrlInputText text: url.
	importPanel versionInputText text: version.
	
	project := importPanel accept.
	
	"Once the project is imported, load project dialog pops up"
	PBLoadProjectDialog allInstances do: #delete.
	
	self assert: project notNil description: 'Unexpected nil project'.
	self assert: project name equals: name.
	self assert: project version printString equals: '0.0.0-N/A'.
	self assert: project description equals: description.
]
