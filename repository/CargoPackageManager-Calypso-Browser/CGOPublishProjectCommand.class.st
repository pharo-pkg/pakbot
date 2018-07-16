"
A command to publish a project and all its packages to a package repository. It will publish to the default Cargo package repository.
"
Class {
	#name : #CGOPublishProjectCommand,
	#superclass : #CGOProjectCommand,
	#category : #'CargoPackageManager-Calypso-Browser-Commands'
}

{ #category : #accessing }
CGOPublishProjectCommand class >> defaultMenuIconName [
	^#publish
]

{ #category : #activation }
CGOPublishProjectCommand class >> systemBrowserMenuActivator [
	<classAnnotation>
	
	^ CmdContextMenuCommandActivation byRootGroupItemFor: PBProjectBrowserItem asCalypsoItemContext, ClyEmptyClassSelectionContext new
]

{ #category : #activation }
CGOPublishProjectCommand class >> systemBrowserShortcutActivator [
	<classAnnotation>
	
	^ CmdShortcutCommandActivation by: $p meta for: PBProjectBrowserItem asCalypsoItemContext 
]

{ #category : #activation }
CGOPublishProjectCommand class >> systemBrowserToolbarActivator [
	<classAnnotation>
	
	^ ClyToolbarCommandActivation
		byItemOf: ClyButtonToolbarGroup
		order: 1020
		for: PBProjectBrowserItem asCalypsoItemContext, ClyEmptyClassSelectionContext new
]

{ #category : #initialization }
CGOPublishProjectCommand >> defaultMenuItemName [
	^ 'Publish'
]

{ #category : #execution }
CGOPublishProjectCommand >> execute [
	project project publishAll 
]
