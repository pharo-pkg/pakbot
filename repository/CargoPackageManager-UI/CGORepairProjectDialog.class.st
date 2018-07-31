Class {
	#name : #CGORepairProjectDialog,
	#superclass : #ComposablePresenter,
	#instVars : [
		'project',
		'reasonPanel',
		'detailPanel',
		'optionsList'
	],
	#category : 'CargoPackageManager-UI-Repair'
}

{ #category : #specs }
CGORepairProjectDialog class >> defaultSpec [
	<spec: #default>
	
	^ SpecLayout composed
		newColumn: [ :column |
			column 
				newRow: #reasonPanel height: 70;
				newRow: #optionsList;
				newRow: #detailPanel ]
]

{ #category : #'instance-creation' }
CGORepairProjectDialog class >> onProject: aProject [
	^ self basicNew
		project: aProject;
		initialize;
		yourself.
]

{ #category : #visiting }
CGORepairProjectDialog >> accept [
	
	self selectedAction execute.
]

{ #category : #accessing }
CGORepairProjectDialog >> detailPanel [
	^ detailPanel
]

{ #category : #api }
CGORepairProjectDialog >> initialExtent [
	^ 700@500
]

{ #category : #initialization }
CGORepairProjectDialog >> initializeWidgets [
	
	reasonPanel := self newReadOnlyText.
	optionsList := self newFastTable.
	detailPanel := self newReadOnlyText.

	reasonPanel widget contentsWrapped: project problemLongDescription.

	optionsList widget 
		dataSource: self newActionsDataSource;
		onAnnouncement: FTSelectionChanged send: #selectionChanged: to: self;
		selectRowIndex: 1. 


]

{ #category : #initialization }
CGORepairProjectDialog >> newActionsDataSource [

	^ FTEasyListDataSource new
		elements: (CGORepairProjectAction allAvailableFor: project);
		display: [ :each | each name ];
		icon: [ :each | self iconNamed: each iconName ];
		yourself
]

{ #category : #api }
CGORepairProjectDialog >> openDialogWithSpec [
	
	^ super openDialogWithSpec
		okAction: [ self accept ];
		yourself
]

{ #category : #accessing }
CGORepairProjectDialog >> optionsList [
	^ optionsList
]

{ #category : #accessing }
CGORepairProjectDialog >> project: aCGOOngoingProject [ 
	project := aCGOOngoingProject
]

{ #category : #accessing }
CGORepairProjectDialog >> reasonPanel [
	^ reasonPanel
]

{ #category : #selection }
CGORepairProjectDialog >> selectedAction [

	| selectedIndex |
	selectedIndex := optionsList widget selectedRowIndex.
	selectedIndex = 0 ifTrue: [ ^ nil ].	
	^ optionsList widget dataSource elementAt: selectedIndex 
		
]

{ #category : #selection }
CGORepairProjectDialog >> selectionChanged: aFTSelectionChanged [ 
	
	detailPanel widget contentsWrapped: (self selectedAction ifNil: [ '' ] ifNotNil: #description).
	
	self window ifNil: [ ^ self ].
	
	self selectedAction 
		ifNil: [ self window toolbar okButton disable ]
		ifNotNil: [ self window toolbar okButton enable ]
]

{ #category : #api }
CGORepairProjectDialog >> title [
	^ 'Repair Cargo Project'
]
