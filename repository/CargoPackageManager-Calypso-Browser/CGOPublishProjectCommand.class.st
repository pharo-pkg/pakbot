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
	
	^ CmdContextMenuActivation byRootGroupItemFor: PBProjectUIItem asCalypsoItemContext, ClyEmptyClassSelectionContext new
]

{ #category : #activation }
CGOPublishProjectCommand class >> systemBrowserShortcutActivator [
	<classAnnotation>
	
	^ CmdShortcutActivation by: $p meta for: PBProjectUIItem asCalypsoItemContext 
]

{ #category : #activation }
CGOPublishProjectCommand class >> systemBrowserToolbarActivator [
	<classAnnotation>
	
	^ ClyToolbarActivation
		byItemOf: ClyButtonToolbarGroup
		order: 1020
		for: PBProjectUIItem asCalypsoItemContext, ClyEmptyClassSelectionContext new
]

{ #category : #initialization }
CGOPublishProjectCommand >> defaultMenuItemName [
	^ 'Publish'
]

{ #category : #execution }
CGOPublishProjectCommand >> execute [
	project publishAll 
]
