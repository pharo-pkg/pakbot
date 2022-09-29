"
I'm a form you can use to create a new project.
"
Class {
	#name : #PBNewProjectPresenter,
	#superclass : #SpOptionPresenter,
	#instVars : [
		'projectPanel'
	],
	#category : #'Pakbot-Browser-Presenters-NewProject'
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

{ #category : #layout }
PBNewProjectPresenter >> defaultLayout [

	^ SpBoxLayout newTopToBottom  
		add: projectPanel;
		yourself
]

{ #category : #accepting }
PBNewProjectPresenter >> doAccept [

	self flag: 'TO DO: validations (call super doAccept)'.
	
	^ (self registry newProjectNamed: projectPanel name)
		version: projectPanel version;
		description: projectPanel description;
		repository: projectPanel repository;
		yourself
]

{ #category : #initialization }
PBNewProjectPresenter >> initializePresenters [
	
	projectPanel := self instantiate: PBLoadableUnitOverviewPresenter on: (PBProjectVersion named: '').
	projectPanel version: ''.
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
PBNewProjectPresenter >> registry [
	
	^ self application registry
]
