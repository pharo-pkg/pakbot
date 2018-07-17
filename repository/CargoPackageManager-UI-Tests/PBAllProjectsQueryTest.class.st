Class {
	#name : #PBAllProjectsQueryTest,
	#superclass : #PBAbstractCalypsoTest,
	#category : #'CargoPackageManager-UI-Tests'
}

{ #category : #tests }
PBAllProjectsQueryTest >> testEmptyProjectsReturnEmptyCollection [

			
	self assert: (PBAllPakbotProjects sortedFrom: scope) execute items isEmpty
]

{ #category : #tests }
PBAllProjectsQueryTest >> testWithOneProjectHasTheCorrectName [

	
	| result |
	registry newProjectNamed: 'TestProject'.
	
	result := (PBAllPakbotProjects sortedFrom: scope) execute items.
	
	self assert: result anyOne name equals: 'TestProject'.	
]

{ #category : #tests }
PBAllProjectsQueryTest >> testWithOneProjectIsNotEmpty [

	
	registry newProjectNamed: 'TestProject'.
	
	self deny: (PBAllPakbotProjects sortedFrom: scope) execute items isEmpty
]

{ #category : #tests }
PBAllProjectsQueryTest >> testWithOneProjectReturnsTheCorrectUIInstance [

	
	| result |
	registry newProjectNamed: 'TestProject'.
	
	result := (PBAllPakbotProjects sortedFrom: scope) execute items.
	
	self assert: result size equals: 1.
	self assert: result anyOne class equals: PBProjectUIItem.	
]
