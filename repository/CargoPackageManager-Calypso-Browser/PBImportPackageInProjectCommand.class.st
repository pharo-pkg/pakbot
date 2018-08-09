"
Calypso command providing a contextual menu to import an existing package as a Cargo package unit
"
Class {
	#name : #PBImportPackageInProjectCommand,
	#superclass : #PBProjectCommand,
	#instVars : [
		'unitName'
	],
	#category : #'CargoPackageManager-Calypso-Browser-Commands'
}

{ #category : #accessing }
PBImportPackageInProjectCommand class >> defaultMenuIconName [

	^ #smallLoadProject
]

{ #category : #activation }
PBImportPackageInProjectCommand class >> systemBrowserMenuActivator [
	<classAnnotation>
	
	^ CmdContextMenuActivation byRootGroupItemOrder: 20 for: PBProjectUIItem asCalypsoItemContext
]

{ #category : #activation }
PBImportPackageInProjectCommand class >> systemBrowserShortcutActivator [
	<classAnnotation>
	
	^ CmdShortcutActivation by: $p meta, $i meta for: PBProjectUIItem asCalypsoItemContext
]

{ #category : #activation }
PBImportPackageInProjectCommand class >> systemBrowserToolbarActivator [
	<classAnnotation>
	^ ClyToolbarActivation
		byItemOf: ClyButtonToolbarGroup
		order: 1000
		for: PBProjectUIItem asCalypsoItemContext
]

{ #category : #activation }
PBImportPackageInProjectCommand class >> systemBrowserToolbarActivatorForPackages [
	<classAnnotation>
	^ ClyToolbarActivation
		byItemOf: ClyButtonToolbarGroup
		order: 1000
		for: PBPackageUIItem asCalypsoItemContext
]

{ #category : #initialization }
PBImportPackageInProjectCommand >> defaultMenuItemName [
	^ 'Import Package'
]

{ #category : #execution }
PBImportPackageInProjectCommand >> execute [
	| dialog |
	dialog := PBSelectPackagesDialog on: project packageCandidates.
	dialog openDialogWithSpec okAction: [ project importPackagesNamed: (dialog selectedItems collect: #name) ]
]
