Class {
	#name : #PBAssemblyUIItemTest,
	#superclass : #PBAbstractCalypsoTest,
	#instVars : [
		'loadedPackage',
		'notLoadedPackage'
	],
	#category : #'CargoPackageManager-UI-Tests'
}

{ #category : #utils }
PBAssemblyUIItemTest >> contextClass [
	^ PBPackageContextOfFullBrowser 
]

{ #category : #running }
PBAssemblyUIItemTest >> setUp [
	| assembly package |
	super setUp.

	project := registry newProjectNamed: 'TestProject'.
	assembly := project addAssemblyNamed: 'Assembly'.
	package := project createPackageNamed: 'TestProject-Core'.
	assembly addPackage: package
]

{ #category : #tests }
PBAssemblyUIItemTest >> testAProjectShowsAssemblies [

	| projectUI assembly |

	projectUI := self findProject: 'TestProject'.
	assembly := self findUIItem: 'Assembly'.

	self deny: projectUI items isEmpty.	
	self assert: assembly isAssembly.
]

{ #category : #tests }
PBAssemblyUIItemTest >> testRemoveAssemblyCommandRemovesIt [

	| projectUI assembly |

	projectUI := self findProject: 'TestProject'.
	assembly := self findUIItem: 'Assembly'.

	(self command: PBDeleteAssemblyCommand for: assembly) executeCommand.
	
	self expandNodeNamed: 'TestProject'.
	self assert: (self findUIItem: 'TestProject-Core') isNil.
]
