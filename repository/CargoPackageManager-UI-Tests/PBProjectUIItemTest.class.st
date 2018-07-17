Class {
	#name : #PBProjectUIItemTest,
	#superclass : #PBAbstractCalypsoTest,
	#instVars : [
		'project'
	],
	#category : #'CargoPackageManager-UI-Tests'
}

{ #category : #tests }
PBProjectUIItemTest >> findProject: aName [

	^ (PBAllPakbotProjects sortedFrom: scope) execute items detect: [ :each | each name = aName ] ifNone: [ nil ]
]

{ #category : #tests }
PBProjectUIItemTest >> testCreatingAProjectCreatesTheCorrectUIItem [

	registry newProjectNamed: 'TestProject'.
	project := self findProject: 'TestProject'.	
	self assert: project isNotNil.	
]
