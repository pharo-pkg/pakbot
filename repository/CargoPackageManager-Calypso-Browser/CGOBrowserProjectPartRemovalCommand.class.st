"
Calypso command providing a contextual menu to remove a part of  a Cargo project (i.e. a package unit or a package assembly).
It does not actually remove the Rpackage associated to a package unit if the later is removed with this command.
"
Class {
	#name : #CGOBrowserProjectPartRemovalCommand,
	#superclass : #CGOProjectCommand,
	#instVars : [
		'packageToRemove'
	],
	#category : 'CargoPackageManager-Calypso-Browser-CargoPackageManager-Calypso-Browser'
}

{ #category : #accessing }
CGOBrowserProjectPartRemovalCommand class >> canBeExecutedInContext: aToolContext [
	^ aToolContext hasSelectedItems "and: [ aToolContext lastSelectedObject isRemovable ]"
]

{ #category : #accessing }
CGOBrowserProjectPartRemovalCommand class >> defaultMenuIconName [
	^#delete
]

{ #category : #activation }
CGOBrowserProjectPartRemovalCommand class >> systemBrowserAssemblyMenuActivator [
	<classAnnotation>
	
	^ CmdContextMenuActivation byRootGroupItemFor: ClyProjectChildItem asCalypsoItemContext  
]

{ #category : #activation }
CGOBrowserProjectPartRemovalCommand class >> systemBrowserAssemblyShortcutActivator [
	<classAnnotation>
	
	^ CmdShortcutActivation by: $x meta, $p meta for: ClyProjectChildItem asCalypsoItemContext   
]

{ #category : #activation }
CGOBrowserProjectPartRemovalCommand class >> systemBrowserShortcutActivator [
	<classAnnotation>
	
	^ CmdShortcutActivation by: $x meta, $p meta for: ClyProjectChildItem asCalypsoItemContext   
]

{ #category : #activation }
CGOBrowserProjectPartRemovalCommand class >> systemBrowserUnitMenuActivator [
	<classAnnotation>
	
	^ CmdContextMenuActivation byRootGroupItemFor: ClyPackageContextOfFullBrowser 
]

{ #category : #activation }
CGOBrowserProjectPartRemovalCommand class >> systemBrowserUnitShortcutActivator [
	<classAnnotation>
	
	^ CmdShortcutActivation by: $x meta, $p meta for: ClyPackageContextOfFullBrowser 
]

{ #category : #initialization }
CGOBrowserProjectPartRemovalCommand >> defaultMenuItemName [
	^ 'Remove package from project'
]

{ #category : #execution }
CGOBrowserProjectPartRemovalCommand >> execute [
	project removePart: packageToRemove cargoPackage
]

{ #category : #execution }
CGOBrowserProjectPartRemovalCommand >> prepareFullExecutionInContext: aToolContext [

	super prepareFullExecutionInContext: aToolContext.
	packageToRemove := aToolContext lastSelectedObject.

]

{ #category : #private }
CGOBrowserProjectPartRemovalCommand >> refreshCalypsoChild [
	toolContext lastSelectedItem parentItem childrenDataSource 
		ifNotNil: [:ds | ds environmentCursor observedContent changedBy: nil]
]
