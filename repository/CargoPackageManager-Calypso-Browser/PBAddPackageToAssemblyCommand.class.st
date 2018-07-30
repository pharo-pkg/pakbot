Class {
	#name : #PBAddPackageToAssemblyCommand,
	#superclass : #PBAssemblyCommand,
	#category : #'CargoPackageManager-Calypso-Browser-Commands'
}

{ #category : #accessing }
PBAddPackageToAssemblyCommand class >> defaultMenuIconName [

	^ #smallLoadProject
]

{ #category : #accessing }
PBAddPackageToAssemblyCommand class >> systemBrowserMenuActivator [
	<classAnnotation>
	
	^ CmdContextMenuActivation byRootGroupItemOrder: 20 for: PBAssemblyUIItem asCalypsoItemContext
]

{ #category : #accessing }
PBAddPackageToAssemblyCommand >> defaultMenuItemName [
	^ 'Add Package(s)'
]

{ #category : #execution }
PBAddPackageToAssemblyCommand >> execute [
	
	| dialog |
	dialog := PBSelectPackagesDialog on: assembly packageCandidates.
	dialog openDialogWithSpec okAction: [
		assembly addPackages: dialog selectedItems ]
]
