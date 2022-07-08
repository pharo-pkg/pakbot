"
A small UI to search published projects and their available versions
"
Class {
	#name : #PBPackageRepositoryPresenter,
	#superclass : #SpPresenterWithModel,
	#instVars : [
		'projectList',
		'versionList'
	],
	#category : #'Pakbot-Browser-Repository'
}

{ #category : #initialization }
PBPackageRepositoryPresenter >> buildContextMenu [
		
	^ SpMenuPresenter new 
			addItem: [ :subMenuItem | subMenuItem name: 'Inspect project'; action: [ self inspect ] ];
			addItem: [ :subMenuItem | subMenuItem name: 'Inspect metadata file'; action: [ self inspectSelectedProjectMetadataFile ] ];
			yourself
]

{ #category : #initialization }
PBPackageRepositoryPresenter >> connectPresenters [

	projectList
		transmitTo: versionList
		transform: [ :projectName | self repository versionsOf: projectName ]
]

{ #category : #layout }
PBPackageRepositoryPresenter >> defaultLayout [ 

	^ SpBoxLayout newLeftToRight
		spacing: 10;
		add: projectList;
		add: versionList;
		yourself
]

{ #category : #initialization }
PBPackageRepositoryPresenter >> initializePresenters [ 
	projectList := self newFilteringList
		items: self repository packages;
		yourself.
		
	
	versionList := self newFilteringList.
	versionList listPresenter 
		contextMenu: self buildContextMenu;
		whenActivatedDo: [ self openProjectBrowserOnSelection ]
]

{ #category : #initialization }
PBPackageRepositoryPresenter >> initializeWindow: aWindowPresenter [

	aWindowPresenter
		title: 'Pakbot repository browser';
		initialExtent: 500@300
]

{ #category : #action }
PBPackageRepositoryPresenter >> inspectSelectedProjectMetadataFile [

	| project version |
	project := projectList selectedItem.
	version := versionList selectedItem.
	
	(self repository fileForPackageNamed: project version: version) inspect.
]

{ #category : #action }
PBPackageRepositoryPresenter >> openProjectBrowserOnSelection [

	| project version projectVersion registry |
	project := projectList selectedItem.
	version := versionList selectedItem.
	projectVersion := self repository fetch: project version: version.
	registry := PBPackageRegistry new.
	registry registerProject: projectVersion.
	
	PakbotBrowser new
		registry: registry;
		startWithoutActions.
]

{ #category : #accessing }
PBPackageRepositoryPresenter >> repository [
	^ self model
]
