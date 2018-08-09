Class {
	#name : #PBProjectUIItemTest,
	#superclass : #PBAbstractCalypsoTest,
	#category : #'CargoPackageManager-UI-Tests'
}

{ #category : #tests }
PBProjectUIItemTest >> setUp [

	super setUp.
	testRegistry newProjectNamed: 'TestProject'.
	project := self findProject: 'TestProject'.	
]

{ #category : #tests }
PBProjectUIItemTest >> testAddAssemblyCommand [

	| cmd assembly |	
	self openBrowser.
	cmd := self command: PBCreateAssemblyCommand for: project.
	
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
	cmd := self command: PBCreatePackageInProjectCommand for: project.

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
	commands := self commandsOfItem: project.

	self assertCommands: commands includes: PBCreatePackageInProjectCommand.
	self assertCommands: commands includes: PBImportPackageInProjectCommand.
	self assertCommands: commands includes: PBRemoveProjectCommand.
	self assertCommands: commands includes: CGOPublishProjectCommand.
	self assertCommands: commands includes: PBSetupProjectRepositoryCommand.
]

{ #category : #tests }
PBProjectUIItemTest >> testCreatingAProjectCreatesTheCorrectUIItem [

	"Check the setUp"
	
	self assert: project isNotNil.	
]

{ #category : #tests }
PBProjectUIItemTest >> testNewProjectHasNoElements [

	"Check the setUp"
	self assert: project items isEmpty
]

{ #category : #tests }
PBProjectUIItemTest >> testNewProjectIsEmpty [

	"Check the setUp"
	self assert: project isEmpty.	
]
