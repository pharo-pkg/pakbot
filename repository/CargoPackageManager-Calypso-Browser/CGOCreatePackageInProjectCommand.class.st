"
Calypso command providing a contextual menu to create a new (empty) Cargo package unit
"
Class {
	#name : #CGOCreatePackageInProjectCommand,
	#superclass : #CGOProjectCommand,
	#instVars : [
		'unitName'
	],
	#category : 'CargoPackageManager-Calypso-Browser-CargoPackageManager-Calypso-Browser'
}

{ #category : #accessing }
CGOCreatePackageInProjectCommand class >> canBeExecutedInContext: aToolContext [
	^ aToolContext isProjectSelected
]

{ #category : #accessing }
CGOCreatePackageInProjectCommand class >> defaultMenuIconName [
	^#packageAdd
]

{ #category : #activation }
CGOCreatePackageInProjectCommand class >> systemBrowserMenuActivator [
	<classAnnotation>
	
	^ CmdContextMenuActivation byRootGroupItemOrder: 10 for: ClyManagedProject asCalypsoItemContext
]

{ #category : #activation }
CGOCreatePackageInProjectCommand class >> systemBrowserShortcutActivator [
	<classAnnotation>
	
	^ CmdShortcutActivation by: $p meta, $n meta for: ClyManagedProject asCalypsoItemContext
]

{ #category : #activation }
CGOCreatePackageInProjectCommand class >> systemBrowserToolbarActivator [
	<classAnnotation>
	^ ClyToolbarCommandActivation
		byItemOf: ClyButtonToolbarGroup
		order: 1000
		for: ClyManagedProject asCalypsoItemContext
]

{ #category : #execution }
CGOCreatePackageInProjectCommand >> createSystemPackage [
	SycAddNewPackageCommand new
		systemEnvironment: toolContext systemEnvironment;
		packageName: unitName;
		execute
]

{ #category : #initialization }
CGOCreatePackageInProjectCommand >> defaultMenuItemName [
	^ 'New Package'
]

{ #category : #execution }
CGOCreatePackageInProjectCommand >> execute [
	unitName := UIManager default 
		request: 'New package name' 
		initialAnswer: project name, '-'.
	unitName isEmptyOrNil ifTrue: [ CmdCommandAborted signal ].
	project createPackageNamed: unitName.
]
