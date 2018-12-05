"
Command to create a tag on the current commit
"
Class {
	#name : #PBTagProjectCommand,
	#superclass : #PBProjectCommand,
	#category : #'CargoPackageManager-Calypso-Browser-Commands'
}

{ #category : #accessing }
PBTagProjectCommand class >> canBeExecutedInContext: aToolContext [

	^ aToolContext isProjectSelected 
		and: [ aToolContext selectedProjectItems size = 1
		and: [ aToolContext selectedProjectItems first actualObject project hasRepository ] ]
]

{ #category : #accessing }
PBTagProjectCommand class >> defaultMenuIconName [
	^ #glamorousBookmark
]

{ #category : #activation }
PBTagProjectCommand class >> systemBrowserMenuActivator [
	<classAnnotation>
	
	^ CmdContextMenuActivation
		byItemOf: PBSCMMenuGroup
		order: 10000
		for: PBProjectUIItem asCalypsoItemContext 
]

{ #category : #activation }
PBTagProjectCommand class >> systemBrowserShortcutActivator [
	<classAnnotation>
	
	^ CmdShortcutActivation by: $t meta for: PBProjectUIItem asCalypsoItemContext 
]

{ #category : #activation }
PBTagProjectCommand class >> systemBrowserToolbarActivator [
	<classAnnotation>
	
	^ ClyToolbarActivation
		byItemOf: ClyButtonToolbarGroup
		order: 1010
		for: PBProjectUIItem asCalypsoItemContext , ClyEmptyClassSelectionContext new
]

{ #category : #initialization }
PBTagProjectCommand >> defaultMenuItemName [
	^ 'Tag...'
]

{ #category : #execution }
PBTagProjectCommand >> execute [
	| repositoryModel |
	
	repositoryModel := (IceTipRepositoryModel on: project repository iceRepository) beCached.
	(IceTipCreateTagPanel on: repositoryModel) openDialogWithSpec.
]
