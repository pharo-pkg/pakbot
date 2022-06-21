"
I'm the main presenter of Pakbot Browser.
I present a list of projects with their details.
"
Class {
	#name : #PBBrowserMainPresenter,
	#superclass : #SpPresenter,
	#instVars : [
		'projectsTree',
		'descriptionPanel',
		'rootCommandsGroup',
		'toolbar'
	],
	#category : #'Pakbot-Browser-Presenters'
}

{ #category : #building }
PBBrowserMainPresenter class >> buildCommandsGroupWith: aPBBrowserMainPresenter forRoot: rootCommandGroup [

	rootCommandGroup register: (self buildToolbarGroupContext: aPBBrowserMainPresenter)
]

{ #category : #building }
PBBrowserMainPresenter class >> buildToolbarGroupContext: aContext [

	^ (CmCommandGroup named: 'Toolbar') asSpecGroup
		description: 'Pakbot Browser toolbar';
		register: (PBAddProjectCommand forSpecContext: aContext);
		register: (PBCommitProjectCommand forSpecContext: aContext);
		yourself
]

{ #category : #initialization }
PBBrowserMainPresenter >> buildToolbar [
	
	^ self newToolbar
		fillWith: self toolbarGroup;
		yourself
]

{ #category : #initialization }
PBBrowserMainPresenter >> connectPresenters [
	projectsTree transmitTo: descriptionPanel transform: [ :uiItem | uiItem pakbotItem ].
]

{ #category : #layout }
PBBrowserMainPresenter >> defaultLayout [ 
	^ SpBoxLayout newTopToBottom
		add: toolbar expand: false;
		add: (SpPanedLayout newLeftToRight
			add: projectsTree;
			add: descriptionPanel;
			positionOfSlider: 0.4;
			yourself);
		yourself
	
]

{ #category : #initialization }
PBBrowserMainPresenter >> initializePresenters [
	projectsTree := self newTreeTable
		hideColumnHeaders;
		roots: self roots;
		children: [ :aPBUIItem | aPBUIItem items ];
		addColumn: ((SpImageTableColumn evaluated: [ :aPBUIItem | aPBUIItem icon]) width: 30);
		addColumn: (SpStringTableColumn evaluated: #displayName);
		contextMenu: [ projectsTree selectedItem contextMenu ];
		yourself.
		
	descriptionPanel := self instantiate: PBProjectPresenter on: nil"PBNoProject ?".
	
	toolbar := self buildToolbar.
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

{ #category : #private }
PBBrowserMainPresenter >> rootCommandsGroup [ 
	^ rootCommandsGroup ifNil: [ rootCommandsGroup := super rootCommandsGroup ]
]

{ #category : #accessing }
PBBrowserMainPresenter >> roots [

	^ (self registry registeredProjects sorted: [ :a :b | a name <= b name ])
		collect: [ :project | PBProjectUIItem forProject: project presenter: self ]
]

{ #category : #accessing }
PBBrowserMainPresenter >> selectedPackage [
	^ projectsTree selectedItem isPackage
		ifTrue: [ projectsTree selectedItem pakbotItem ]
		ifFalse: [ nil ]
]

{ #category : #accessing }
PBBrowserMainPresenter >> selectedProject [ 
	^ projectsTree selectedItem ifNotNil: [ :uiItem | uiItem pakbotItem ]
]

{ #category : #private }
PBBrowserMainPresenter >> toolbarGroup [
	^ self rootCommandsGroup / 'Toolbar'
]
