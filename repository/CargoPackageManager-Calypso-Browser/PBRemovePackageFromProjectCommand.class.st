"
Calypso command providing a contextual menu to remove a part of  a Cargo project (i.e. a package unit or a package assembly).
It does not actually remove the Rpackage associated to a package unit if the later is removed with this command.
"
Class {
	#name : #PBRemovePackageFromProjectCommand,
	#superclass : #PBPackageCommand,
	#category : #'CargoPackageManager-Calypso-Browser-Commands'
}

{ #category : #activation }
PBRemovePackageFromProjectCommand class >> canBeExecutedInContext: aToolContext [

	^ aToolContext lastSelectedItem actualObject canBeRemovedFromProject
]

{ #category : #activation }
PBRemovePackageFromProjectCommand class >> systemBrowserMenuActivator [
	<classAnnotation>
	
	^ CmdContextMenuActivation byRootGroupItemOrder: 20 for: PBPackageUIItem asCalypsoItemContext
]

{ #category : #activation }
PBRemovePackageFromProjectCommand class >> systemBrowserShortcutActivator [
	<classAnnotation>
	
	^ CmdShortcutActivation by: $x meta, $p meta for: PBPackageUIItem asCalypsoItemContext   
]

{ #category : #accessing }
PBRemovePackageFromProjectCommand >> defaultMenuIcon [
	^ Smalltalk ui theme iconNamed: #delete
]

{ #category : #initialization }
PBRemovePackageFromProjectCommand >> defaultMenuItemName [
	^ 'Remove package from project'
]

{ #category : #execution }
PBRemovePackageFromProjectCommand >> execute [

	self package removeFromProject
]
