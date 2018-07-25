Class {
	#name : #PBProjectUIItemTest,
	#superclass : #PBAbstractCalypsoTest,
	#category : #'CargoPackageManager-UI-Tests'
}

{ #category : #tests }
PBProjectUIItemTest >> testAddAssemblyCommand [

	| cmd assembly |
	registry newProjectNamed: 'TestProject'.
	
	self openBrowser.
	
	project := self findProject: 'TestProject'.	
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
	registry newProjectNamed: 'TestProject'.
	
	self openBrowser.
	
	project := self findProject: 'TestProject'.	
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
	
	registry newProjectNamed: 'TestProject'.
	project := self findProject: 'TestProject'.	

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

	registry newProjectNamed: 'TestProject'.
	project := self findProject: 'TestProject'.	
	self assert: project isNotNil.	
]

{ #category : #tests }
PBProjectUIItemTest >> testNewProjectHasNoElements [

	registry newProjectNamed: 'TestProject'.
	project := self findProject: 'TestProject'.	

	self assert: project items isEmpty .	
]

{ #category : #tests }
PBProjectUIItemTest >> testNewProjectIsEmpty [

	registry newProjectNamed: 'TestProject'.
	project := self findProject: 'TestProject'.	

	self assert: project isEmpty.	
]

{ #category : #tests }
PBProjectUIItemTest >> testRemoveProjectCommand [

	| cmd pj |
	registry newProjectNamed: 'TestProject'.
	
	self openBrowser.
	
	project := self findProject: 'TestProject'.	
	cmd := self command: PBRemoveProjectCommand for: project.
	cmd executeCommand.
	
	pj := self findUIItem: 'TestProject-Core'.
	
	self assert: pj isNil.
]
