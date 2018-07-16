"
A command to publish a project and all its packages to a package repository. It will publish to the default Cargo package repository.
"
Class {
	#name : #CGOPublishProjectCommand,
	#superclass : #CGOProjectCommand,
	#category : 'CargoPackageManager-Calypso-Browser-CargoPackageManager-Calypso-Browser'
}

{ #category : #testing }
CGOPublishProjectCommand class >> canBeExecutedInContext: aToolContext [
	^ aToolContext isProjectSelected 
]

{ #category : #accessing }
CGOPublishProjectCommand class >> defaultMenuIconName [
	^#publish
]

{ #category : #activation }
CGOPublishProjectCommand class >> systemBrowserMenuActivator [
	<classAnnotation>
	
	^ CmdContextMenuCommandActivation byRootGroupItemFor: ClyManagedProject asCalypsoItemContext, ClyEmptyClassSelectionContext new
]

{ #category : #activation }
CGOPublishProjectCommand class >> systemBrowserShortcutActivator [
	<classAnnotation>
	
	^ CmdShortcutCommandActivation by: $p meta for: ClyManagedProject asCalypsoItemContext 
]

{ #category : #activation }
CGOPublishProjectCommand class >> systemBrowserToolbarActivator [
	<classAnnotation>
	
	^ ClyToolbarCommandActivation
		byItemOf: ClyButtonToolbarGroup
		order: 1020
		for: ClyManagedProject asCalypsoItemContext, ClyEmptyClassSelectionContext new
]

{ #category : #initialization }
CGOPublishProjectCommand >> defaultMenuItemName [
	^ 'Publish'
]

{ #category : #execution }
CGOPublishProjectCommand >> execute [
	project project publishAll 
]
