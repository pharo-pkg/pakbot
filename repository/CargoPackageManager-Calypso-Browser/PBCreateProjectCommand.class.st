"
Calypso command providing a contextual menu to create a new (empty) Cargo project
"
Class {
	#name : #PBCreateProjectCommand,
	#superclass : #CGOClyCommand,
	#instVars : [
		'projectName'
	],
	#category : #'CargoPackageManager-Calypso-Browser-Commands'
}

{ #category : #accessing }
PBCreateProjectCommand class >> canBeExecutedInContext: aToolContext [

	^ aToolContext isProjectSelected not
]

{ #category : #accessing }
PBCreateProjectCommand class >> defaultMenuIconName [
	^#configNew
]

{ #category : #activation }
PBCreateProjectCommand class >> systemBrowserMenuActivator [
	<classAnnotation>
	
	^ CmdContextMenuActivation byRootGroupItemFor: ClyProjectContextOfFullBrowser 
]

{ #category : #activation }
PBCreateProjectCommand class >> systemBrowserShortcutActivator [
	<classAnnotation>
	
	^ CmdShortcutActivation by: $n meta, $p meta for: ClyProjectContextOfFullBrowser
]

{ #category : #activation }
PBCreateProjectCommand class >> systemBrowserToolbarActivator [
	<classAnnotation>
	^ ClyToolbarActivation
		byItemOf: ClyButtonToolbarGroup
		for: ClyProjectContextOfFullBrowser
]

{ #category : #initialization }
PBCreateProjectCommand >> defaultMenuItemName [
	^ 'New project'
]

{ #category : #execution }
PBCreateProjectCommand >> execute [
	
	PBCreateProjectDialog new
		openDialogOnAccept: [ :project | CGOProjectCreated announceOnProject: project ]
		onCancel: [ "Nothing" ]
]
