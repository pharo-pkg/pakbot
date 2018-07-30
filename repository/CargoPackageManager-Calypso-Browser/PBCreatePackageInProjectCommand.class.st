"
Calypso command providing a contextual menu to create a new (empty) Cargo package unit
"
Class {
	#name : #PBCreatePackageInProjectCommand,
	#superclass : #PBProjectCommand,
	#instVars : [
		'unitName'
	],
	#category : #'CargoPackageManager-Calypso-Browser-Commands'
}

{ #category : #accessing }
PBCreatePackageInProjectCommand class >> defaultMenuIconName [
	^#packageAdd
]

{ #category : #activation }
PBCreatePackageInProjectCommand class >> systemBrowserMenuActivator [
	<classAnnotation>
	
	^ CmdContextMenuActivation byRootGroupItemOrder: 10 for: PBProjectUIItem asCalypsoItemContext
]

{ #category : #activation }
PBCreatePackageInProjectCommand class >> systemBrowserShortcutActivator [
	<classAnnotation>
	
	^ CmdShortcutActivation by: $p meta, $n meta for: PBProjectUIItem asCalypsoItemContext
]

{ #category : #activation }
PBCreatePackageInProjectCommand class >> systemBrowserToolbarActivator [
	<classAnnotation>
	^ ClyToolbarActivation
		byItemOf: ClyButtonToolbarGroup
		order: 1000
		for: PBProjectUIItem asCalypsoItemContext
]

{ #category : #activation }
PBCreatePackageInProjectCommand class >> systemBrowserToolbarActivatorForPackage [
	<classAnnotation>
	^ ClyToolbarActivation
		byItemOf: ClyButtonToolbarGroup
		order: 1000
		for: PBPackageUIItem asCalypsoItemContext
]

{ #category : #execution }
PBCreatePackageInProjectCommand >> createSystemPackage [
	SycAddNewPackageCommand new
		systemEnvironment: toolContext systemEnvironment;
		packageName: unitName;
		execute
]

{ #category : #initialization }
PBCreatePackageInProjectCommand >> defaultMenuItemName [
	^ 'New Package'
]

{ #category : #execution }
PBCreatePackageInProjectCommand >> execute [
	unitName := UIManager default 
		request: 'New package name' 
		initialAnswer: project name, '-'.
	unitName isEmptyOrNil ifTrue: [ CmdCommandAborted signal ].
	project createPackageNamed: unitName.
]
