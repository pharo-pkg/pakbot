Class {
	#name : #PBProjectUIItem,
	#superclass : #ClyManagedProject,
	#instVars : [
		'project'
	],
	#category : #'CargoPackageManager-Calypso-Environment-Items'
}

{ #category : #converting }
PBProjectUIItem class >> convertToCalypsoBrowserItem: aProject [ 

	| item |
	item := (PBBrowserItem named: aProject name with: aProject).	
	aProject isEmpty ifFalse: [ item markWithChildrenOf: ClyProjectChildItem].
	^item
]

{ #category : #soting }
PBProjectUIItem class >> defaultSortFunctionForCalypso [
	^ClySortByNameFunction ascending
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

{ #category : #preparing }
PBProjectUIItem class >> prepareProjectItemsQueryFrom: aProjectChildItem in: aNavigationEnvironment [ 

	^ PBProjectItemContentQuery 
			sortedFrom: (PBProjectItemScope of: aProjectChildItem in: aNavigationEnvironment)
]

{ #category : #items }
PBProjectUIItem >> assemblyItems [
	^ ((self project assemblies
		collect: [ :each | PBAssemblyUIItem on: each ])
		asSortedCollection: [ :a :b | a name < b name ]) asOrderedCollection
]

{ #category : #actions }
PBProjectUIItem >> createPackageNamed: aString [ 
	
	^ project createPackageNamed: aString
]

{ #category : #decorating }
PBProjectUIItem >> decorateProblems: anItemCellMorph inContext: itemContext [
	| button activator icon command |	
	command := PBRepairProjectCommand new.
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
PBProjectUIItem >> decorateTableCell: anItemCellMorph inContext: itemContext [

	self project hasProblems
		ifTrue: [ ^ self decorateProblems: anItemCellMorph inContext: itemContext ].
		
	anItemCellMorph definitionIcon: #configLoaded.
]

{ #category : #items }
PBProjectUIItem >> dependenciesItems [

	^ project dependencies
		ifEmpty: [ ^ #() ]
		ifNotEmpty: [ {(PBDependenciesUIGroup onProject: self project)} ]
]

{ #category : #adding }
PBProjectUIItem >> importPackagesNamed: aCollection [ 
	
	aCollection do: [ :aName | project importPackageNamed: aName ]
]

{ #category : #testing }
PBProjectUIItem >> includesPackage: aRPackage [ 
	
	^ self project installedSystemPackages includes: aRPackage
]

{ #category : #testing }
PBProjectUIItem >> installedSystemPackages [
	
	^ self project installedSystemPackages
]

{ #category : #announcements }
PBProjectUIItem >> isAffectedBy: anAnnouncement [

	^ (anAnnouncement isKindOf: CGOProjectAnnouncement)
		and: [ anAnnouncement project = self project ]
]

{ #category : #testing }
PBProjectUIItem >> isEmpty [

	^ self items isEmpty 
]

{ #category : #items }
PBProjectUIItem >> items [
	^ self packageItems , self assemblyItems , self dependenciesItems
]

{ #category : #accessing }
PBProjectUIItem >> name [
	^ project name
]

{ #category : #actions }
PBProjectUIItem >> openRepairDialog [

	^ (PBOpenRepairDialogAction onProject: self project) execute
]

{ #category : #accessing }
PBProjectUIItem >> packageCandidates [

	^ (project registry systemPackageOrganizer packages
		reject: [ :each | project hasPackageNamed: each name ])
		asOrderedCollection
]

{ #category : #items }
PBProjectUIItem >> packageItems [
	^ ((self project packages
		collect: [ :each | PBPackageUIItem on: each ])
		asSortedCollection: [ :a :b | a name < b name ]) asOrderedCollection
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
	
	^ ( project class includesBehavior: aClass ) or: [ self class includesBehavior: aClass ]

]

{ #category : #actions }
PBProjectUIItem >> unregister [
	
	project registry unregisterProject: project.
]
