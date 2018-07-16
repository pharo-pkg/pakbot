Class {
	#name : #PBProjectBrowserItem,
	#superclass : #Object,
	#instVars : [
		'project'
	],
	#category : #'CargoPackageManager-Calypso-Environment-Items'
}

{ #category : #converting }
PBProjectBrowserItem class >> convertToCalypsoBrowserItem: aProject [ 

	^ClyBrowserItem named: aProject name with: aProject
]

{ #category : #preparing }
PBProjectBrowserItem class >> decorateBrowserItem: aBrowserItem by: anEnvironmentPlugin [

	aBrowserItem actualObject decorate: aBrowserItem.
	
]

{ #category : #sorting }
PBProjectBrowserItem class >> defaultSortFunctionForCalypso [

	^ ClySortByNameFunction ascending
]

{ #category : #accessing }
PBProjectBrowserItem class >> forProject: aProject [

	^ self new
		project: aProject;
		yourself
]

{ #category : #preparing }
PBProjectBrowserItem class >> prepareClassQueriesFrom: aCollection in: aClyNavigationEnvironment [ 
	
	"The project should not should the classes, they are in the package"
	^ #()
]

{ #category : #queries }
PBProjectBrowserItem class >> prepareProjectItemsQueryFrom: aProject in: aNavigationEnvironment [ 

	^ PBProjectContentQuery 
			sortedFrom: (PBProjectScope of: aProject in: aNavigationEnvironment)
]

{ #category : #decorating }
PBProjectBrowserItem >> decorate: aClyBrowserItem [ 

	aClyBrowserItem markWithChildrenOf: PBProjectChildBrowserItem

]

{ #category : #decorating }
PBProjectBrowserItem >> decorateProblems: anItemCellMorph inContext: itemContext [
	| button activator icon command |
	command := CGORepairProjectCommand new.
	itemContext prepareNewCommand: command.
	activator := CmdCommandActivator new
		command: command;
		context: itemContext.
	icon := anItemCellMorph iconNamed: #error.
	button := command createTableCellButtonWith: icon using: activator.
	button setBalloonText: 'The project is not up to date'.
	anItemCellMorph definitionMorph: button
]

{ #category : #decorating }
PBProjectBrowserItem >> decorateTableCell: anItemCellMorph inContext: itemContext [
	self project hasProblems
		ifTrue: [ ^ self decorateProblems: anItemCellMorph inContext: itemContext ].
		
	anItemCellMorph definitionIcon: #configLoaded.
]

{ #category : #testing }
PBProjectBrowserItem >> isEmpty [

	^ false
]

{ #category : #testing }
PBProjectBrowserItem >> items [
	1halt.
]

{ #category : #accessing }
PBProjectBrowserItem >> name [
	^ project name
]

{ #category : #accessing }
PBProjectBrowserItem >> project [
	^ project
]

{ #category : #accessing }
PBProjectBrowserItem >> project: aCGOOngoingProject [ 
	project := aCGOOngoingProject
]
