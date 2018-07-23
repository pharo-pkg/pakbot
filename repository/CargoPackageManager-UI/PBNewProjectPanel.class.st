Class {
	#name : #PBNewProjectPanel,
	#superclass : #ITOptionPanel,
	#instVars : [
		'projectPanel'
	],
	#category : #'CargoPackageManager-UI-NewProject'
}

{ #category : #specs }
PBNewProjectPanel class >> defaultSpec [
	<spec: #default>

	^ SpecLayout composed 
		newColumn: [ :col | 
			col newRow: #projectPanel ]
]

{ #category : #accessing }
PBNewProjectPanel >> icon [

	^ self iconNamed: #dirtyPackage
]

{ #category : #initialization }
PBNewProjectPanel >> initializeWidgets [
	
	projectPanel := PBLoadableUnitOverview newOn: (PBProject named: '') owner: self
]

{ #category : #opening }
PBNewProjectPanel >> openDialogOnAccept: aBlockClosure onCancel: aBlockClosure2 [ 
	
	self openDialogWithSpec 
]

{ #category : #accessing }
PBNewProjectPanel >> projectPanel [
	^ projectPanel
]

{ #category : #accessing }
PBNewProjectPanel >> projectPanel: anObject [
	projectPanel := anObject
]

{ #category : #accessing }
PBNewProjectPanel >> title [

	^ 'New Project'
]
