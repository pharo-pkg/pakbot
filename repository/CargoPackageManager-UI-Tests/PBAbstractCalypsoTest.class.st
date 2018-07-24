Class {
	#name : #PBAbstractCalypsoTest,
	#superclass : #CGOAbstractTest,
	#instVars : [
		'systemEnvironment',
		'navigationEnvironment',
		'scope',
		'registry',
		'query',
		'project',
		'browser'
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

{ #category : #utilties }
PBAbstractCalypsoTest >> command: aCommandClass for: anItem [
	^ (self commandsOfItem: anItem) detect: [ :each | each command isKindOf: aCommandClass ]
]

{ #category : #utils }
PBAbstractCalypsoTest >> commandsOfItem: anItem [
	| aContext selection datasource |
	datasource := ClyCollapsedDataSource empty.
	selection := ClyDataSourceSelection
		fromRoot: datasource
		items: {(ClyDataSourceItem of: datasource value: anItem asCalypsoBrowserItem)}.
	aContext := self contextClass ofSelection: selection for: browser.
	^ CmdContextMenuActivation createActivatorsExecutableInContext: aContext
]

{ #category : #utils }
PBAbstractCalypsoTest >> contextClass [
	^ ClyProjectContextOfFullBrowser
]

{ #category : #utilities }
PBAbstractCalypsoTest >> expandNodeNamed: aString [ 
	
	| items datasource |
	datasource := browser packageView table dataSource.	
	items := datasource findItemsWhere: [ :each | each name = aString ].
	items do: [ :each | each expand ].
]

{ #category : #utility }
PBAbstractCalypsoTest >> findChildInBrowser: aString [ 
	
	| datasource column |
	
	datasource := browser packageView table dataSource.
	column := browser packageView table columns at: 1.
	
	^ ((1 to: datasource numberOfRows) collect: [ :i | 
		datasource cellColumn: column row: i]) detect: [ :anItem | anItem label contents beginsWith: aString ] ifNone: [ nil ]
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
PBAbstractCalypsoTest >> openBrowser [
	browser := ClyFullBrowser
		on: navigationEnvironment
		systemScope: navigationEnvironment systemScope.
	browser switchToProjects.
	browser open
]

{ #category : #running }
PBAbstractCalypsoTest >> setUp [
	super setUp.
	registry := CGOPackageRegistry new.
	systemEnvironment := ClySystemEnvironment new.

	systemEnvironment projectManager
		registerProjectManager: (CGOCalypsoPackageManager forRegistry: registry).

	navigationEnvironment := ClyNavigationEnvironment
		overSystemEnvironment: systemEnvironment.

	scope := navigationEnvironment systemScope.
	query := PBAllPakbotProjects sortedFrom: scope.

	
]

{ #category : #tests }
PBAbstractCalypsoTest >> tearDown [

	super tearDown.

	browser ifNotNil: [ browser close. browser := nil. ].
	project ifNotNil: [ project installedSystemPackages do: #removeFromSystem ].
]
