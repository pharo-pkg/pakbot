Class {
	#name : #PBImportProjectFromGitTest,
	#superclass : #PBAbstractTest,
	#instVars : [
		'project',
		'panel',
		'name',
		'url',
		'version',
		'description',
		'importPanel',
		'defaultRegistry',
		'gitCredentials'
	],
	#category : #'CargoPackageManager-UI-Tests'
}

{ #category : #tests }
PBImportProjectFromGitTest >> setUp [
	super setUp.
	
	defaultRegistry := PBPackageRegistry default.
	PBPackageRegistry default: testRegistry.
		
	importPanel := PBImportProjectFromGitPanel new.
	importPanel iceErrorVisitor: IceErrorVisitorForTests new.
		
	name := #'PharoCounter'.
	url := 'https://github.com/pharo-pkg/pharo-counter.git'.
	description := 'A simple counter project. You can increment it, decrement it and get the value from the counter.'.
	
	"workaround. Cannot inherit from PBTestCaseWithGitCredentials"
	gitCredentials := PBTestCaseWithGitCredentials new. 
	gitCredentials setUp.
]

{ #category : #tests }
PBImportProjectFromGitTest >> tearDown [ 
	super tearDown.
	
	PBPackageRegistry default: defaultRegistry.
	gitCredentials tearDown.
]

{ #category : #tests }
PBImportProjectFromGitTest >> testCloneErrorIsCaptured [

	url := 'https://github.com/pharo-pkg/unexisting-repo.git'.
	importPanel repositoryUrlInputText text: url.
	
	self 
		shouldnt: [ importPanel accept ]
		raise: IceCloneError, IceAuthenticationError.
	
	self assert: project isNil description: 'Expected nil project'.
]

{ #category : #tests }
PBImportProjectFromGitTest >> testGetRequiredProjectVersionAfterAccept [
	self skip.
	self flag: 'first need tag support'.
	version := '0.1'.
	importPanel repositoryUrlInputText text: url.
	importPanel versionInputText text: version.
	
	project := importPanel accept.
	
	"Once the project is imported, load project dialog pops up"
	PBLoadProjectDialog allInstances do: #delete.
	
	self assert: project notNil description: 'Unexpected nil project'.
	self assert: project name equals: name.
	self assert: project version printString equals: '0.1'.
	self assert: project description equals: description.
]

{ #category : #tests }
PBImportProjectFromGitTest >> testProjectIsFilledAfterAccept [

	version := ''.
	importPanel repositoryUrlInputText text: url.
	importPanel versionInputText text: version.
	
	project := importPanel accept.
	
	"Once the project is imported, load project dialog pops up"
	PBLoadProjectDialog allInstances do: #delete.
	
	self assert: project notNil description: 'Unexpected nil project'.
	self assert: project name equals: name.
	self assert: project version class equals: PBNoVersion.
	self assert: project description equals: description.
]
