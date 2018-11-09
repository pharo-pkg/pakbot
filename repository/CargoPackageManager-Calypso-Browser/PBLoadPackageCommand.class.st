"
Calypso command providing a contextual menu to load a package defined as a Cargo package unit
"
Class {
	#name : #PBLoadPackageCommand,
	#superclass : #PBPackageCommand,
	#category : #'CargoPackageManager-Calypso-Browser-Commands'
}

{ #category : #accessing }
PBLoadPackageCommand class >> canBeExecutedInContext: aToolContext [
	^ aToolContext lastSelectedPackage isInstalled not 
]

{ #category : #activation }
PBLoadPackageCommand class >> systemBrowserMenuActivator [
	<classAnnotation>
	
	^ CmdContextMenuActivation byRootGroupItemOrder: 20 for: PBPackageUIItem asCalypsoItemContext
]

{ #category : #execution }
PBLoadPackageCommand >> applyResultInContext: aToolContext [
	super applyResultInContext: aToolContext.
	[ aToolContext activeQueryView refreshTable ]
	on: NotFound 
	do: [ :e | "ignore. I do not get why this could happen. " ]
]

{ #category : #accessing }
PBLoadPackageCommand >> defaultMenuIcon [
	^ Smalltalk ui theme iconNamed: #glamorousUp
]

{ #category : #accessing }
PBLoadPackageCommand >> defaultMenuItemName [
	^ 'Load Package'
]

{ #category : #execution }
PBLoadPackageCommand >> execute [

	self packageItem load
]
