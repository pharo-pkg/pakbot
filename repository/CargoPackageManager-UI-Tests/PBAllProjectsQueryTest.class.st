Class {
	#name : #PBAllProjectsQueryTest,
	#superclass : #PBAbstractCalypsoTest,
	#category : #'CargoPackageManager-UI-Tests'
}

{ #category : #tests }
PBAllProjectsQueryTest >> testEmptyProjectsReturnEmptyCollection [

			
	self assert: query execute items isEmpty
]

{ #category : #tests }
PBAllProjectsQueryTest >> testWithOneProjectHasTheCorrectName [

	
	| result |
	testRegistry newProjectNamed: 'TestProject'.
	
	result := query execute items.
	
	self assert: result anyOne name equals: 'TestProject'.	
]

{ #category : #tests }
PBAllProjectsQueryTest >> testWithOneProjectIsNotEmpty [

	
	testRegistry newProjectNamed: 'TestProject'.
	
	self deny: query execute items isEmpty
]

{ #category : #tests }
PBAllProjectsQueryTest >> testWithOneProjectReturnsTheCorrectUIInstance [

	
	| result |
	testRegistry newProjectNamed: 'TestProject'.
	
	result := query execute items.
	
	self assert: result size equals: 1.
	self assert: result anyOne class equals: PBProjectUIItem.	
]
