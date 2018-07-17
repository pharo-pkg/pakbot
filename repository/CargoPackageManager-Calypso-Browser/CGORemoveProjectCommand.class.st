Class {
	#name : #CGORemoveProjectCommand,
	#superclass : #CGOProjectCommand,
	#category : #'CargoPackageManager-Calypso-Browser-Commands'
}

{ #category : #accessing }
CGORemoveProjectCommand class >> defaultMenuIconName [
	^ #remove
]

{ #category : #activation }
CGORemoveProjectCommand class >> defaultMenuItemName [
	^ 'Remove Project'
]

{ #category : #activation }
CGORemoveProjectCommand class >> systemBrowserMenuActivator [
	<classAnnotation>
	
	^ CmdContextMenuActivation byRootGroupItemOrder: 20 for: PBProjectUIItem asCalypsoItemContext
]

{ #category : #execution }
CGORemoveProjectCommand >> execute [
	
	self project unregister.

]
