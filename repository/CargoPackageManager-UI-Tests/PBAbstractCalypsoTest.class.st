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
PBAbstractCalypsoTest >> assertCommands: commands include: aClass [

	self assert: (commands anySatisfy: [ :each | each command class = aClass ])
]

{ #category : #utils }
PBAbstractCalypsoTest >> commandsOfItem: anItem [ 
	
	| aContext selection datasource |
	datasource := ClyCollapsedDataSource empty.	
	selection := ClyDataSourceSelection fromRoot: datasource items: {ClyDataSourceItem of: datasource value: anItem asCalypsoBrowserItem}.
	aContext := PBProjectContextOfFullBrowser ofSelection: selection for: ClyFullBrowser new.
	
	^ CmdContextMenuActivation createActivatorsExecutableInContext: aContext
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
	systemEnvironment projectManager registerPackageManager: (CGOCalypsoPackageManager forRegistry: registry). 
	
	navigationEnvironment := ClyNavigationEnvironment overSystemEnvironment: systemEnvironment.
	scope := navigationEnvironment systemScope.

	query := PBAllPakbotProjects sortedFrom: scope.
]

{ #category : #tests }
PBAbstractCalypsoTest >> tearDown [

	super tearDown.
	
	project ifNotNil: [ project installedSystemPackages do: #removeFromSystem ].
]
