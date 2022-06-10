"
I'm the main presenter of Pakbot Browser.
I present a list of projects with their details.
"
Class {
	#name : #PBBrowserMainPresenter,
	#superclass : #SpPresenter,
	#instVars : [
		'projectsTree',
		'descriptionPanel'
	],
	#category : #'Pakbot-Browser-Presenters'
}

{ #category : #initialization }
PBBrowserMainPresenter >> connectPresenters [
	projectsTree transmitTo: descriptionPanel.
]

{ #category : #layout }
PBBrowserMainPresenter >> defaultLayout [ 
	^ SpPanedLayout newLeftToRight
		add: projectsTree;
		add: descriptionPanel;
		positionOfSlider: 0.4;
		yourself
	
]

{ #category : #initialization }
PBBrowserMainPresenter >> initializePresenters [
	projectsTree := self newTreeTable
		hideColumnHeaders;
		roots: self registry registeredProjects;
		children: [ :aTemplateGroup | #() ];
		addColumn: ((SpImageTableColumn evaluated: [ :project | self iconNamed: project iconName]) width: 30);
		addColumn: (SpStringTableColumn evaluated: #name);
		"contextMenuFromCommandsGroup: [ self rootCommandsGroup / 'Context Menu' ];"
		yourself.
		
	descriptionPanel := self instantiate: PBProjectPresenter on: nil"PBNoProject ?".
]

{ #category : #initialization }
PBBrowserMainPresenter >> initializeWindow: aWindowPresenter [

	aWindowPresenter
		title: 'Pakbot Browser';
		initialExtent: 800 @ 600.
]

{ #category : #initialization }
PBBrowserMainPresenter >> modelChanged [
	
]

{ #category : #accessing }
PBBrowserMainPresenter >> registry [
	^ self application registry
]
