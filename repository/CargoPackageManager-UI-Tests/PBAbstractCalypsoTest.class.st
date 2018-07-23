Class {
	#name : #PBAbstractCalypsoTest,
	#superclass : #CGOAbstractTest,
	#instVars : [
		'systemEnvironment',
		'navigationEnvironment',
		'scope',
		'registry',
		'query',
		'project'
	],
	#category : #'CargoPackageManager-UI-Tests'
}

{ #category : #tests }
PBAbstractCalypsoTest >> assertCommands: commands includes: aClass [

	self assert: (commands anySatisfy: [ :each | each command class = aClass ])
]

{ #category : #tests }
PBAbstractCalypsoTest >> assertCommands: commands notIncludes: aClass [

	self assert: (commands noneSatisfy: [ :each | each command class = aClass ])
]

{ #category : #utils }
PBAbstractCalypsoTest >> commandsOfItem: anItem [
	| aContext selection datasource |
	datasource := ClyCollapsedDataSource empty.
	selection := ClyDataSourceSelection
		fromRoot: datasource
		items: {(ClyDataSourceItem of: datasource value: anItem asCalypsoBrowserItem)}.
	aContext := self contextClass ofSelection: selection for: ClyFullBrowser new.
	^ CmdContextMenuActivation createActivatorsExecutableInContext: aContext
]

{ #category : #utils }
PBAbstractCalypsoTest >> contextClass [
	^ ClyProjectContextOfFullBrowser
]

{ #category : #tests }
PBAbstractCalypsoTest >> findPackage: aName [
	| projectUI |
	
	projectUI := self findProject: project name.
	^ projectUI items detect: [ :each | each name = aName ] ifNone: [ nil ]
	

]

{ #category : #tests }
PBAbstractCalypsoTest >> findProject: aName [

	^ query execute items detect: [ :each | each name = aName ] ifNone: [ nil ]
]

{ #category : #running }
PBAbstractCalypsoTest >> setUp [
	super setUp.
	
	registry := CGOPackageRegistry new.
	
	systemEnvironment := ClySystemEnvironment new.
	systemEnvironment projectManager registerProjectManager: (CGOCalypsoPackageManager forRegistry: registry). 
	
	navigationEnvironment := ClyNavigationEnvironment overSystemEnvironment: systemEnvironment.
	scope := navigationEnvironment systemScope.

	query := PBAllPakbotProjects sortedFrom: scope.
]

{ #category : #tests }
PBAbstractCalypsoTest >> tearDown [

	super tearDown.

	project ifNotNil: [ project installedSystemPackages do: #removeFromSystem ].
]
