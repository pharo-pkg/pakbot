Class {
	#name : #PBDeleteAssemblyCommand,
	#superclass : #PBAssemblyCommand,
	#category : #'CargoPackageManager-Calypso-Browser-Commands'
}

{ #category : #accessing }
PBDeleteAssemblyCommand class >> defaultMenuIconName [

	^ #delete
]

{ #category : #accessing }
PBDeleteAssemblyCommand class >> systemBrowserMenuActivator [
	<classAnnotation>
	
	^ CmdContextMenuActivation byRootGroupItemOrder: 20 for: PBAssemblyUIItem asCalypsoItemContext
]

{ #category : #accessing }
PBDeleteAssemblyCommand >> defaultMenuItemName [
	^ 'Remove Assembly'
]

{ #category : #execution }
PBDeleteAssemblyCommand >> execute [

	assembly remove
]
