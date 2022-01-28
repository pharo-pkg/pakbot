"
I'm a form you can use to create a new project.
"
Class {
	#name : #PBNewProjectPresenter,
	#superclass : #SpOptionPresenter,
	#instVars : [
		'projectPanel'
	],
	#category : #'CargoPackageManager-UI-NewProject'
}

{ #category : #examples }
PBNewProjectPresenter class >> example [
	| panel editionPanel |
	
	panel := self new.
	editionPanel := panel projectPanel.
	
	editionPanel registry: PBPackageRegistry new.
	editionPanel name: 'aName'.
	editionPanel version: '1.0.0'.
	editionPanel description: 'A description'.
	
	panel open
]

{ #category : #accepting }
PBNewProjectPresenter >> accept [

	| project |
	projectPanel accept.
	project := projectPanel loadableUnit.
	self registry registerProject: project.
	^ project
]

{ #category : #layout }
PBNewProjectPresenter >> defaultLayout [

	^ SpBoxLayout newTopToBottom  
		add: projectPanel;
		yourself
]

{ #category : #initialization }
PBNewProjectPresenter >> initializePresenters [
	
	projectPanel := self instantiate: PBLoadableUnitOverviewPanel on: (PBProjectVersion named: '').
]

{ #category : #accessing }
PBNewProjectPresenter >> optionIcon [

	^ self iconNamed: #dirtyPackage
]

{ #category : #accessing }
PBNewProjectPresenter >> optionTitle [

	^ 'New Project'
]

{ #category : #accessing }
PBNewProjectPresenter >> projectPanel [
	^ projectPanel
]

{ #category : #accessing }
PBNewProjectPresenter >> projectPanel: anObject [
	projectPanel := anObject
]

{ #category : #accessing }
PBNewProjectPresenter >> registry [
	
	^ projectPanel registry
]
