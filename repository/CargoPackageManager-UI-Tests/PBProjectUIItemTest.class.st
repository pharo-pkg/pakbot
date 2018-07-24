Class {
	#name : #PBProjectUIItemTest,
	#superclass : #PBAbstractCalypsoTest,
	#category : #'CargoPackageManager-UI-Tests'
}

{ #category : #tests }
PBProjectUIItemTest >> testAddPackageCommand [

	| cmd pkg |
	registry newProjectNamed: 'TestProject'.
	
	self openBrowser.
	
	project := self findProject: 'TestProject'.	
	cmd := self command: CGOCreatePackageInProjectCommand for: project.

	UIManager nonInteractiveDuring: [ 
		[cmd executeCommand] 
			on: ProvideAnswerNotification 
			do: [ :ex | ex resume: 'TestProject-Core' ] ].
	
	pkg := self findPackage: 'TestProject-Core'.
	
	self assert: pkg isNotNil.
]

{ #category : #tests }
PBProjectUIItemTest >> testAnEmptyProjectHasTheCorrectCommands [

	| commands |
	
	registry newProjectNamed: 'TestProject'.
	project := self findProject: 'TestProject'.	

	self openBrowser.
	commands := self commandsOfItem: project.

	self assertCommands: commands includes: CGOCreatePackageInProjectCommand.
	self assertCommands: commands includes: CGOImportPackageInProjectCommand.
	self assertCommands: commands includes: CGORemoveProjectCommand.
	self assertCommands: commands includes: CGOPublishProjectCommand.
	self assertCommands: commands includes: CGOCommitProjectCommand.	
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
	cmd := self command: CGORemoveProjectCommand for: project.
	cmd executeCommand.
	
	pj := self findPackage: 'TestProject-Core'.
	
	self assert: pj isNil.
]
