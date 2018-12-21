"
A command to publish a project and all its packages to a package repository. It will publish to the default Cargo package repository.
"
Class {
	#name : #PBPublishProjectCommand,
	#superclass : #PBProjectCommand,
	#category : #'CargoPackageManager-Calypso-Browser-Commands'
}

{ #category : #accessing }
PBPublishProjectCommand class >> defaultMenuIconName [
	^#publish
]

{ #category : #activation }
PBPublishProjectCommand class >> systemBrowserMenuActivator [
	<classAnnotation>
	
	^ CmdContextMenuActivation byRootGroupItemFor: PBProjectUIItem asCalypsoItemContext, ClyEmptyClassSelectionContext new
]

{ #category : #activation }
PBPublishProjectCommand class >> systemBrowserShortcutActivator [
	<classAnnotation>
	
	^ CmdShortcutActivation by: $p meta for: PBProjectUIItem asCalypsoItemContext 
]

{ #category : #activation }
PBPublishProjectCommand class >> systemBrowserToolbarActivator [
	<classAnnotation>
	
	^ ClyToolbarActivation
		byItemOf: ClyButtonToolbarGroup
		order: 1020
		for: PBProjectUIItem asCalypsoItemContext, ClyEmptyClassSelectionContext new
]

{ #category : #initialization }
PBPublishProjectCommand >> defaultMenuItemName [
	^ 'Publish'
]

{ #category : #execution }
PBPublishProjectCommand >> execute [
	project publish
]
