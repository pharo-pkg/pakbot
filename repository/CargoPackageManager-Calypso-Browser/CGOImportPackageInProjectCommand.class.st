"
Calypso command providing a contextual menu to import an existing package as a Cargo package unit
"
Class {
	#name : #CGOImportPackageInProjectCommand,
	#superclass : #CGOProjectCommand,
	#instVars : [
		'unitName'
	],
	#category : #'CargoPackageManager-Calypso-Browser-Commands'
}

{ #category : #accessing }
CGOImportPackageInProjectCommand class >> defaultMenuIconName [

	^ #smallLoadProject
]

{ #category : #activation }
CGOImportPackageInProjectCommand class >> systemBrowserMenuActivator [
	<classAnnotation>
	
	^ CmdContextMenuActivation byRootGroupItemOrder: 20 for: PBProjectUIItem asCalypsoItemContext
]

{ #category : #activation }
CGOImportPackageInProjectCommand class >> systemBrowserShortcutActivator [
	<classAnnotation>
	
	^ CmdShortcutActivation by: $p meta, $i meta for: PBProjectUIItem asCalypsoItemContext
]

{ #category : #activation }
CGOImportPackageInProjectCommand class >> systemBrowserToolbarActivator [
	<classAnnotation>
	^ ClyToolbarActivation
		byItemOf: ClyButtonToolbarGroup
		order: 1000
		for: PBProjectUIItem asCalypsoItemContext
]

{ #category : #activation }
CGOImportPackageInProjectCommand class >> systemBrowserToolbarActivatorForPackages [
	<classAnnotation>
	^ ClyToolbarActivation
		byItemOf: ClyButtonToolbarGroup
		order: 1000
		for: PBPackageUIItem asCalypsoItemContext
]

{ #category : #execution }
CGOImportPackageInProjectCommand >> createSystemPackage [
	SycAddNewPackageCommand new
		systemEnvironment: toolContext systemEnvironment;
		packageName: unitName;
		execute
]

{ #category : #initialization }
CGOImportPackageInProjectCommand >> defaultMenuItemName [
	^ 'Import Package'
]

{ #category : #execution }
CGOImportPackageInProjectCommand >> execute [
	| dialog |
	dialog := PBImportPackagesDialog on: project project.
	dialog openDialogWithSpec okAction: [ dialog accept ]
]
