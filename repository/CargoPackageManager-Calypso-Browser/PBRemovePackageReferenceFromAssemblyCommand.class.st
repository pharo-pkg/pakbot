Class {
	#name : #PBRemovePackageReferenceFromAssemblyCommand,
	#superclass : #PBPackageCommand,
	#category : #'CargoPackageManager-Calypso-Browser-Commands'
}

{ #category : #accessing }
PBRemovePackageReferenceFromAssemblyCommand class >> canBeExecutedInContext: aToolContext [

	^ aToolContext lastSelectedItem actualObject canBeRemovedFromAssembly
]

{ #category : #activation }
PBRemovePackageReferenceFromAssemblyCommand class >> systemBrowserMenuActivator [
	<classAnnotation>
	
	^ CmdContextMenuActivation byRootGroupItemOrder: 20 for: PBPackageUIItem asCalypsoItemContext
]

{ #category : #activation }
PBRemovePackageReferenceFromAssemblyCommand class >> systemBrowserShortcutActivator [
	<classAnnotation>
	
	^ CmdShortcutActivation by: $x meta, $p meta for: PBPackageUIItem asCalypsoItemContext   
]

{ #category : #accessing }
PBRemovePackageReferenceFromAssemblyCommand >> defaultMenuIcon [
	^ Smalltalk ui theme iconNamed: #delete
]

{ #category : #initialization }
PBRemovePackageReferenceFromAssemblyCommand >> defaultMenuItemName [
	^ 'Remove package from assembly'
]

{ #category : #execution }
PBRemovePackageReferenceFromAssemblyCommand >> execute [

	self package removeFromAssembly
]
