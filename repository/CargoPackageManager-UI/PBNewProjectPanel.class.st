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

{ #category : #accepting }
PBNewProjectPanel >> accept [

	projectPanel accept.
	self registry registerProject: projectPanel loadableUnit.
]

{ #category : #accessing }
PBNewProjectPanel >> icon [

	^ self iconNamed: #dirtyPackage
]

{ #category : #initialization }
PBNewProjectPanel >> initializeWidgets [
	
	projectPanel := PBLoadableUnitOverviewPanel newOn: (PBProject named: '') owner: self.
]

{ #category : #opening }
PBNewProjectPanel >> openDialogOnAccept: aBlockClosure onCancel: aBlockClosure2 [ 
	
	self openDialogWithSpec 
]

{ #category : #accessing }
PBNewProjectPanel >> project [
	
	^ projectPanel loadableUnit
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
PBNewProjectPanel >> registry [
	
	^ projectPanel registry
]

{ #category : #accessing }
PBNewProjectPanel >> title [

	^ 'New Project'
]
