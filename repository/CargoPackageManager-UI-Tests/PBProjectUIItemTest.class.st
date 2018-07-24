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

	self assertCommands: commands includes: CGOCreatePackageInProjectCommand.
	self assertCommands: commands includes: CGOImportPackageInProjectCommand.
	self assertCommands: commands includes: CGORemoveProjectCommand.
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
