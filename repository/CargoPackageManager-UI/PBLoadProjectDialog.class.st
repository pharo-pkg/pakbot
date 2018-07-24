"
Small dialiog window to ask the user what to load? metadata, all, assembly?

	(self onProject: (PBProject example assemblies: { PBAssembly example }; yourself)) openDialogWithSpec 
"
Class {
	#name : #PBLoadProjectDialog,
	#superclass : #ComposablePresenter,
	#instVars : [
		'project',
		'optionsList',
		'detailPanel'
	],
	#category : #'CargoPackageManager-UI-Loading'
}

{ #category : #specs }
PBLoadProjectDialog class >> defaultSpec [
	<spec: #default>
	
	^ SpecLayout composed 
		newColumn: [ :column |
			column 
				newRow: #optionsList;
				newRow: #detailPanel ]
]

{ #category : #'instance creation' }
PBLoadProjectDialog class >> onProject: aProject [ 
	^ self basicNew
		initializeWithProject: aProject;
		yourself.
]

{ #category : #action }
PBLoadProjectDialog >> accept [
	
	self selectedAction execute.
]

{ #category : #accessing }
PBLoadProjectDialog >> detailPanel [
	^ detailPanel
]

{ #category : #initialization }
PBLoadProjectDialog >> initialExtent [
	^ 500@300
]

{ #category : #initialization }
PBLoadProjectDialog >> initializeWidgets [
	
	optionsList := self newFastTable.
	detailPanel := self newReadOnlyText.

	optionsList widget 
		dataSource: self loadOptionsDataSource;
		onAnnouncement: FTSelectionChanged send: #selectionChanged: to: self;
		selectRowIndex: 1. 


]

{ #category : #initialization }
PBLoadProjectDialog >> initializeWithProject: aProject [ 
	project := aProject.
	super initialize.
]

{ #category : #initialization }
PBLoadProjectDialog >> loadOptionsDataSource [

	^ FTEasyListDataSource new
		elements: (PBLoadProjectAction allAvailableFor: project);
		display: [ :each | each name ];
		icon: [ :each | self iconNamed: each iconName ];
		yourself
]

{ #category : #opening }
PBLoadProjectDialog >> openDialogWithSpec [
	^ super openDialogWithSpec
		okAction: [ self accept ];
		yourself
]

{ #category : #accessing }
PBLoadProjectDialog >> optionsList [
	^ optionsList
]

{ #category : #private }
PBLoadProjectDialog >> selectedAction [

	| selectedIndex |
	selectedIndex := optionsList widget selectedRowIndex.
	selectedIndex = 0 ifTrue: [ ^ nil ].	
	^ optionsList widget dataSource elementAt: selectedIndex 
]

{ #category : #private }
PBLoadProjectDialog >> selectionChanged: aFTSelectionChanged [ 
	
	detailPanel widget contentsWrapped: (self selectedAction ifNil: [ '' ] ifNotNil: #description).
	
	self window ifNil: [ ^ self ].
	
	self selectedAction 
		ifNil: [ self window toolbar okButton disable ]
		ifNotNil: [ self window toolbar okButton enable ]
]

{ #category : #accessing }
PBLoadProjectDialog >> title [
	^ 'Load Project'
]
