Class {
	#name : #PBProjectUIItemTest,
	#superclass : #PBAbstractCalypsoTest,
	#category : #'CargoPackageManager-UI-Tests'
}

{ #category : #tests }
PBProjectUIItemTest >> testAnEmptyProjectHasTheCorrectCommands [

	| commands |
	
	registry newProjectNamed: 'TestProject'.
	project := self findProject: 'TestProject'.	
	commands := self commandsOfItem: project.

	self assertCommands: commands include: CGOCreatePackageInProjectCommand.
	self assertCommands: commands include: CGOImportPackageInProjectCommand.
	self assertCommands: commands include: CGORemoveProjectCommand.
	self assertCommands: commands include: CGOPublishProjectCommand.
	self assertCommands: commands include: CGOCommitProjectCommand.	
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
