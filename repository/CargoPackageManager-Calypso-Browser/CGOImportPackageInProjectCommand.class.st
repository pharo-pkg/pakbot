"
Calypso command providing a contextual menu to import an existing package as a Cargo package unit
"
Class {
	#name : #CGOImportPackageInProjectCommand,
	#superclass : #CGOProjectCommand,
	#instVars : [
		'unitName'
	],
	#category : 'CargoPackageManager-Calypso-Browser-CargoPackageManager-Calypso-Browser'
}

{ #category : #accessing }
CGOImportPackageInProjectCommand class >> canBeExecutedInContext: aToolContext [
	^ aToolContext isProjectSelected
]

{ #category : #accessing }
CGOImportPackageInProjectCommand class >> defaultMenuIconName [

	^ #smallLoadProject
]

{ #category : #activation }
CGOImportPackageInProjectCommand class >> systemBrowserMenuActivator [
	<classAnnotation>
	
	^ CmdContextMenuCommandActivation byRootGroupItemOrder: 20 for: ClyManagedProject asCalypsoItemContext
]

{ #category : #activation }
CGOImportPackageInProjectCommand class >> systemBrowserShortcutActivator [
	<classAnnotation>
	
	^ CmdShortcutCommandActivation by: $p meta, $i meta for: ClyManagedProject asCalypsoItemContext
]

{ #category : #activation }
CGOImportPackageInProjectCommand class >> systemBrowserToolbarActivator [
	<classAnnotation>
	^ ClyToolbarCommandActivation
		byItemOf: ClyButtonToolbarGroup
		order: 1000
		for: ClyManagedProject asCalypsoItemContext
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
	dialog := CGOImportPackagesDialog on: project.
	dialog openDialogWithSpec
		okAction: [
			dialog accept.
			self refreshCalypsoChild ].
]
