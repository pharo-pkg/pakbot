Class {
	#name : #PBRemoveProjectCommand,
	#superclass : #CGOProjectCommand,
	#category : #'CargoPackageManager-Calypso-Browser-Commands'
}

{ #category : #accessing }
PBRemoveProjectCommand class >> defaultMenuIconName [
	^ #remove
]

{ #category : #activation }
PBRemoveProjectCommand class >> defaultMenuItemName [
	^ 'Remove Project'
]

{ #category : #activation }
PBRemoveProjectCommand class >> systemBrowserMenuActivator [
	<classAnnotation>
	
	^ CmdContextMenuActivation byRootGroupItemOrder: 20 for: PBProjectUIItem asCalypsoItemContext
]

{ #category : #execution }
PBRemoveProjectCommand >> execute [
	
	self project unregister.

]
