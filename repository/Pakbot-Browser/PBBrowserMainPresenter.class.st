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
	projectsTree transmitTo: descriptionPanel transform: [ :uiItem | uiItem pakbotItem ].
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
		roots: self roots;
		children: [ :aPBUIItem | aPBUIItem items ];
		addColumn: ((SpImageTableColumn evaluated: [ :project | self iconNamed: project iconName]) width: 30);
		addColumn: (SpStringTableColumn evaluated: #displayName);
		"contextMenuFromCommandsGroup: [ self rootCommandsGroup / 'Context Menu' ];"
		yourself.
		
	descriptionPanel := self instantiate: PBProjectPresenter on: nil"PBNoProject ?".
]

{ #category : #initialization }
PBBrowserMainPresenter >> initializeWindow: aWindowPresenter [

	aWindowPresenter
		title: 'Pakbot Browser';
		initialExtent: 850 @ 600.
]

{ #category : #initialization }
PBBrowserMainPresenter >> modelChanged [
	
]

{ #category : #accessing }
PBBrowserMainPresenter >> registry [
	^ self application registry
]

{ #category : #accessing }
PBBrowserMainPresenter >> roots [

	^ self registry registeredProjects
		collect: [ :project | PBProjectUIItem forProject: project ]
]
