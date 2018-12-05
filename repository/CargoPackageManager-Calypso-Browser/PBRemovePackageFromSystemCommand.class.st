"
Calypso command providing a contextual menu to remove the Rpackage associated to a package unit.
"
Class {
	#name : #PBRemovePackageFromSystemCommand,
	#superclass : #PBPackageCommand,
	#category : #'CargoPackageManager-Calypso-Browser-Commands'
}

{ #category : #activation }
PBRemovePackageFromSystemCommand class >> canBeExecutedInContext: aToolContext [

	^ aToolContext lastSelectedItem actualObject isInstalled
]

{ #category : #activation }
PBRemovePackageFromSystemCommand class >> systemBrowserMenuActivator [
	<classAnnotation>
	
	^ CmdContextMenuActivation byRootGroupItemOrder: 20 for: PBPackageUIItem asCalypsoItemContext
]

{ #category : #accessing }
PBRemovePackageFromSystemCommand >> defaultMenuIcon [
	^ Smalltalk ui theme iconNamed: #delete
]

{ #category : #initialization }
PBRemovePackageFromSystemCommand >> defaultMenuItemName [
	^ 'Remove package from project and system'
]

{ #category : #execution }
PBRemovePackageFromSystemCommand >> execute [

	self package systemPackage removeFromSystem
]
