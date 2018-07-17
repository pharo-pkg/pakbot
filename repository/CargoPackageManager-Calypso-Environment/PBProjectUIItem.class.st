Class {
	#name : #PBProjectUIItem,
	#superclass : #PBAbstractUIItem,
	#instVars : [
		'project'
	],
	#category : #'CargoPackageManager-Calypso-Environment-Items'
}

{ #category : #converting }
PBProjectUIItem class >> convertToCalypsoBrowserItem: aProject [ 

	^PBBrowserItem named: aProject name with: aProject
]

{ #category : #preparing }
PBProjectUIItem class >> decorateBrowserItem: aBrowserItem by: anEnvironmentPlugin [

	aBrowserItem actualObject decorate: aBrowserItem.
	
]

{ #category : #sorting }
PBProjectUIItem class >> defaultSortFunctionForCalypso [

	^ ClySortByNameFunction ascending
]

{ #category : #accessing }
PBProjectUIItem class >> forProject: aProject [

	^ self new
		project: aProject;
		yourself
]

{ #category : #preparing }
PBProjectUIItem class >> prepareClassQueriesFrom: aCollection in: aClyNavigationEnvironment [ 
	
	"The project should not should the classes, they are in the package"
	^ #()
]

{ #category : #queries }
PBProjectUIItem class >> prepareProjectItemsQueryFrom: aProject in: aNavigationEnvironment [ 

	^ PBProjectContentQuery 
			sortedFrom: (PBProjectScope of: aProject in: aNavigationEnvironment)
]

{ #category : #decorating }
PBProjectUIItem >> decorate: aClyBrowserItem [ 

	aClyBrowserItem markWithChildrenOf: PBPackageUIItem

]

{ #category : #decorating }
PBProjectUIItem >> decorate: anItemCellMorph inContext: itemContext [
	self project hasProblems
		ifTrue: [ ^ self decorateProblems: anItemCellMorph inContext: itemContext ].
		
	anItemCellMorph definitionIcon: #configLoaded.
]

{ #category : #decorating }
PBProjectUIItem >> decorateProblems: anItemCellMorph inContext: itemContext [
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

{ #category : #testing }
PBProjectUIItem >> includesPackage: aRPackage [ 
	
	^ self project installedSystemPackages includes: aRPackage
]

{ #category : #testing }
PBProjectUIItem >> installedSystemPackages [
	
	^ self project installedSystemPackages
]

{ #category : #testing }
PBProjectUIItem >> isEmpty [

	^ self project packageUnits isEmpty
]

{ #category : #testing }
PBProjectUIItem >> items [
	
	^ self project packageUnits collect: [ :each | PBPackageUIItem forUnit: each ]
]

{ #category : #accessing }
PBProjectUIItem >> name [
	^ project name
]

{ #category : #actions }
PBProjectUIItem >> openRepairDialog [

	^ (CGOOpenRepairDialog onProject: self project) execute
]

{ #category : #accessing }
PBProjectUIItem >> project [
	^ project
]

{ #category : #accessing }
PBProjectUIItem >> project: aCGOOngoingProject [ 
	project := aCGOOngoingProject
]

{ #category : #testing }
PBProjectUIItem >> representsItemOfType: aClass [ 
	
	self flag: #todo.
	^ aClass = self class or: [aClass = project class]
]

{ #category : #actions }
PBProjectUIItem >> unregister [
	
	project registry unregisterProject: project.
]
