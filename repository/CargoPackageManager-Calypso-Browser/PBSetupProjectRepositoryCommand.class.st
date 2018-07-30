Class {
	#name : #PBSetupProjectRepositoryCommand,
	#superclass : #PBProjectCommand,
	#category : #'CargoPackageManager-Calypso-Browser-Commands'
}

{ #category : #accessing }
PBSetupProjectRepositoryCommand class >> canBeExecutedInContext: aToolContext [

	^ (aToolContext isProjectSelected and: [ aToolContext selectedProjectItems size = 1 ])
		and: [ aToolContext selectedProjectItems first actualObject project hasRepository not ]
]

{ #category : #accessing }
PBSetupProjectRepositoryCommand class >> defaultMenuIconName [

	^#databaseAdd
]

{ #category : #activation }
PBSetupProjectRepositoryCommand class >> systemBrowserMenuActivator [
	<classAnnotation>
	
	^ CmdContextMenuActivation
		byItemOf: CGOSCMMenuGroup
		order: 10000
		for: PBProjectUIItem asCalypsoItemContext 
]

{ #category : #activation }
PBSetupProjectRepositoryCommand class >> systemBrowserToolbarActivator [
	<classAnnotation>
	
	^ ClyToolbarActivation
		byItemOf: ClyButtonToolbarGroup
		order: 1010
		for: PBProjectUIItem asCalypsoItemContext , ClyEmptyClassSelectionContext new
]

{ #category : #initialization }
PBSetupProjectRepositoryCommand >> defaultMenuItemName [
	^ 'Setup Repository'
]

{ #category : #execution }
PBSetupProjectRepositoryCommand >> execute [
	
	(PBOpenNewRepositoryDialogAction onProject: project) execute
]
