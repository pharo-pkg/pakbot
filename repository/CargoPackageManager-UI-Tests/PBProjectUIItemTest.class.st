Class {
	#name : #PBProjectUIItemTest,
	#superclass : #PBAbstractCalypsoTest,
	#instVars : [
		'projectUIItem'
	],
	#category : #'CargoPackageManager-UI-Tests'
}

{ #category : #running }
PBProjectUIItemTest >> assertCommands: activators includes: aClass [
	^ activators 
		detect:  [ :each | each command class = aClass ]
		ifFound: [ :activator | activator ]
		ifNone: [ self fail: 'cannot find command ' , aClass name ]
]

{ #category : #utility }
PBProjectUIItemTest >> projectUIItem [
	^ projectUIItem
]

{ #category : #tests }
PBProjectUIItemTest >> setUp [

	super setUp.
	project := testRegistry newProjectNamed: 'TestProject'.
	project repository: PBGitMemoryRepository new.
	projectUIItem := self findProject: 'TestProject'.	
]

{ #category : #tests }
PBProjectUIItemTest >> testAddAssemblyCommand [

	| cmd assembly |	
	self openBrowser.
	cmd := self command: PBCreateAssemblyCommand for: projectUIItem.
	
	[cmd executeCommand] 
		on: ProvideAnswerNotification 
		do: [ :ex | ex resume: 'Tests' ].
	
	assembly := self findUIItem: 'Tests'.
	
	self assert: assembly isNotNil.
]

{ #category : #tests }
PBProjectUIItemTest >> testAddPackageCommand [

	| cmd pkg |
	self openBrowser.
	cmd := self command: PBCreatePackageInProjectCommand for: projectUIItem.

	[cmd executeCommand] 
		on: ProvideAnswerNotification 
		do: [ :ex | ex resume: 'TestProject-Core' ].
	
	pkg := self findUIItem: 'TestProject-Core'.
	
	self assert: pkg isNotNil.
]

{ #category : #tests }
PBProjectUIItemTest >> testAnEmptyProjectHasTheCorrectCommands [

	| commands |
	self openBrowser.
	commands := self commandsOfItem: projectUIItem.

	self assertCommands: commands includes: PBCreatePackageInProjectCommand.
	self assertCommands: commands includes: PBImportPackageInProjectCommand.
	self assertCommands: commands includes: PBRemoveProjectCommand.
	self assertCommands: commands includes: PBPublishProjectCommand.
	self assertCommands: commands includes: PBSetupProjectRepositoryCommand.
]

{ #category : #tests }
PBProjectUIItemTest >> testAnEmptyProjectHasTheCorrectCommandsWhenRepositoryIsSet [

	| repository commands |
	repository := PBIceMemoryRepository new.
	repository 
		name: projectUIItem project name;
		location: '/'.
	PBTestIcebergWorkingCopy repository: repository.
	projectUIItem project repository: repository.

	self openBrowser.
	commands := self commandsOfItem: projectUIItem.
	
	{ PBCommitProjectCommand . PBTagProjectCommand . PBOpenProjectWorkingCopyCommand } 
		do: [ :commandClass | | activator |
				activator := self assertCommands: commands includes: commandClass.
				self assert: activator command project isNil.
				activator prepareCommandForExecution.
				self assert: (activator command project isKindOf: PBProject) ].
]

{ #category : #tests }
PBProjectUIItemTest >> testCreatingAProjectCreatesTheCorrectUIItem [

	"Check the setUp"
	
	self assert: projectUIItem isNotNil.	
]

{ #category : #tests }
PBProjectUIItemTest >> testNewProjectHasNoElements [

	"Check the setUp"
	self assert: projectUIItem items isEmpty
]

{ #category : #tests }
PBProjectUIItemTest >> testNewProjectIsEmpty [

	"Check the setUp"
	self assert: projectUIItem isEmpty.	
]
