Class {
	#name : #PBNewProjectPanel,
	#superclass : #SpOptionPresenter,
	#instVars : [
		'projectPanel'
	],
	#category : #'CargoPackageManager-UI-NewProject'
}

{ #category : #examples }
PBNewProjectPanel class >> example [
	| panel editionPanel |
	
	panel := self new.
	editionPanel := panel projectPanel.
	
	editionPanel registry: PBPackageRegistry new.
	editionPanel nameInputField text: 'aName'.
	editionPanel versionInputField text: '1.0.0'.
	editionPanel descriptionText text: 'A description'.
	
	panel openWithSpec
]

{ #category : #accepting }
PBNewProjectPanel >> accept [

	| project |
	projectPanel accept.
	project := projectPanel loadableUnit.
	self registry registerProject: project.
	^ project
]

{ #category : #layout }
PBNewProjectPanel >> defaultLayout [

	^ SpBoxLayout newTopToBottom  
		add: projectPanel;
		yourself
]

{ #category : #accessing }
PBNewProjectPanel >> icon [

	^ self iconNamed: #dirtyPackage
]

{ #category : #initialization }
PBNewProjectPanel >> initializeWidgets [
	
	projectPanel := self instantiate: PBLoadableUnitOverviewPanel on: (PBProjectVersion named: '').
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
PBNewProjectPanel >> registry [
	
	^ projectPanel registry
]

{ #category : #accessing }
PBNewProjectPanel >> title [

	^ 'New Project'
]
