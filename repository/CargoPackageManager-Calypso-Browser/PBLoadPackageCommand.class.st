Class {
	#name : #PBLoadPackageCommand,
	#superclass : #PBPackageCommand,
	#category : #'CargoPackageManager-Calypso-Browser-Commands'
}

{ #category : #accessing }
PBLoadPackageCommand class >> canBeExecutedInContext: aToolContext [
	^ aToolContext package isInstalled not 
]

{ #category : #activation }
PBLoadPackageCommand class >> systemBrowserMenuActivator [
	<classAnnotation>
	
	^ CmdContextMenuActivation byRootGroupItemOrder: 20 for: PBPackageUIItem asCalypsoItemContext
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

	self package load
]
