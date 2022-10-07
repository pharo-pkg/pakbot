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
		register: (PBPublishProjectCommand forSpecContext: aContext);
		register: (PBLoadFullProjectCommand forSpecContext: aContext);
		register: (PBOpenGitRepositoryCommand forSpecContext: aContext);
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

	projectsTree
		transmitTo: descriptionPanel
		transform: [ :uiItem | uiItem ifNotNil: [ :item | item pakbotItem ] ]
]

{ #category : #layout }
PBBrowserMainPresenter >> coreLayout [ 
	^ SpPanedLayout newLeftToRight
			add: projectsTree;
			add: descriptionPanel;
			positionOfSlider: 0.4;
			yourself
	
]

{ #category : #layout }
PBBrowserMainPresenter >> defaultLayout [ 
	^ SpBoxLayout newTopToBottom
		add: toolbar expand: false;
		add: self coreLayout;
		yourself
	
]

{ #category : #private }
PBBrowserMainPresenter >> delete [
	
	super delete.
	self unsubscribe.
]

{ #category : #configuring }
PBBrowserMainPresenter >> disableActions [
	"useful when used to present data that is not part of the system"
	
	self layout: self coreLayout.
	projectsTree contextMenu: nil.
	
]

{ #category : #refreshing }
PBBrowserMainPresenter >> handleProjectChanged: announcement [

	| path |
	path := projectsTree selection selectedPath.
	projectsTree selectPath: { path first }.
	self refreshKeepingSelection.
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
	self listenToPakbotAnnouncements.
]

{ #category : #initialization }
PBBrowserMainPresenter >> initializeWindow: aWindowPresenter [

	aWindowPresenter
		title: 'Pakbot Browser';
		initialExtent: 850 @ 600.
]

{ #category : #'event-listening' }
PBBrowserMainPresenter >> listenToPakbotAnnouncements [
	
	Pakbot announcer weak
		when: PBProjectCreated, PBProjectRemoved, PBProjectChanged, PBProjectLoaded  
			send: #refresh
			to: self.
]

{ #category : #initialization }
PBBrowserMainPresenter >> modelChanged [
	
]

{ #category : #refreshing }
PBBrowserMainPresenter >> refresh [
	projectsTree roots: self roots
]

{ #category : #refreshing }
PBBrowserMainPresenter >> refreshKeepingSelection [
	projectsTree updateRootsKeepingSelection: self roots
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
PBBrowserMainPresenter >> selectedAssembly [

	^ self selectedPakbotItemIfTrue: [ self selectedItem isAssembly ]
]

{ #category : #accessing }
PBBrowserMainPresenter >> selectedItem [

	^ projectsTree selectedItem
]

{ #category : #accessing }
PBBrowserMainPresenter >> selectedPackage [
	
	^ self selectedPakbotItemIfTrue: [ self selectedItem isPackage ]
]

{ #category : #private }
PBBrowserMainPresenter >> selectedPakbotItemIfTrue: aBlock [

	^ aBlock value
		ifTrue: [ self selectedItem pakbotItem ]
		ifFalse: [ nil ]
]

{ #category : #accessing }
PBBrowserMainPresenter >> selectedProject [ 

	^ self selectedPakbotItemIfTrue: [ self selectedItem isProject ]
]

{ #category : #private }
PBBrowserMainPresenter >> toolbarGroup [
	^ self rootCommandsGroup / 'Toolbar'
]

{ #category : #'event-listening' }
PBBrowserMainPresenter >> unsubscribe [
	
	Pakbot announcer unsubscribe: self.
]
