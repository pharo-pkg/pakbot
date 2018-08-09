Class {
	#name : #PBUnloadProjectDialog,
	#superclass : #ComposablePresenter,
	#instVars : [
		'project',
		'iconPanel',
		'messageLabel',
		'removePackagesCheckBox',
		'dependentsPanel',
		'dependentsLabel'
	],
	#category : #'CargoPackageManager-UI-Unloading'
}

{ #category : #'instance creation' }
PBUnloadProjectDialog class >> onProject: aProject [ 
	^ self basicNew
		project: aProject;
		initialize;
		yourself.
]

{ #category : #action }
PBUnloadProjectDialog >> accept [

	removePackagesCheckBox state
		ifTrue: [ project unloadRemovingPackages ]
		ifFalse: [ project unload ]
]

{ #category : #specs }
PBUnloadProjectDialog >> defaultSpec [
	<spec: #default>
	
	^ self hasDependents 
		ifTrue: [ self withDependentsSpec ]
		ifFalse: [ self withoutDependentsSpec ]
	

]

{ #category : #accessing }
PBUnloadProjectDialog >> dependentsLabel [
	^ dependentsLabel
]

{ #category : #accessing }
PBUnloadProjectDialog >> dependentsPanel [
	^ dependentsPanel
]

{ #category : #initialization }
PBUnloadProjectDialog >> hasDependents [

	^ project dependantProjects isEmpty not
]

{ #category : #accessing }
PBUnloadProjectDialog >> iconPanel [
	^ iconPanel
]

{ #category : #initialization }
PBUnloadProjectDialog >> initialExtent [
	^ self hasDependents ifTrue: [ 500@300 ] ifFalse: [ 500@170 ]
]

{ #category : #initialization }
PBUnloadProjectDialog >> initializeDependentPanel [
	
	| dataSource |
	
	self hasDependents ifFalse: [ ^ self ].
		
	dependentsPanel := self newIceTreeTable.
	dependentsLabel := self newLabel label: 'The following project depends on ' , project name.
	
	dataSource := FTEasyListDataSource new 
		elements: project dependantProjects;
		display: [ :each | each name ];
		icon: [ :each | self iconNamed: #glamorousBookmark ];
		yourself.
	
	dependentsPanel widget dataSource: dataSource.
]

{ #category : #initialization }
PBUnloadProjectDialog >> initializeWidgets [
	
	iconPanel := self newPanel.
	iconPanel widget addMorph: ((self iconNamed: #remove) scaledToSize: 32@32) asMorph.
	
	messageLabel := self newReadOnlyText.
	messageLabel widget contentsWrapped: self message.
	messageLabel widget
		hResizing: #spaceFill;
		vResizing: #spaceFill.
		
	removePackagesCheckBox := self newCheckBox label: 'Also Remove the Packages from Image'.
	
	self initializeDependentPanel
]

{ #category : #initialization }
PBUnloadProjectDialog >> message [
	
	^ 'Do you want to remove project ' , project name ,' ?'
]

{ #category : #accessing }
PBUnloadProjectDialog >> messageLabel [
	^ messageLabel
]

{ #category : #opening }
PBUnloadProjectDialog >> openDialogWithSpec [
	^ super openDialogWithSpec
		okAction: [ self accept ];
		yourself
]

{ #category : #accessing }
PBUnloadProjectDialog >> project: aPBProject [ 
	project := aPBProject
]

{ #category : #accessing }
PBUnloadProjectDialog >> removePackagesCheckBox [

	^ removePackagesCheckBox
]

{ #category : #api }
PBUnloadProjectDialog >> retrieveSpec: aSelector [
	| layout |
	
	layout := self perform: aSelector.
	layout isSpecLayout ifTrue: [ layout selector: aSelector ].
	^ layout
]

{ #category : #accessing }
PBUnloadProjectDialog >> title [
	^ 'Remove Project'
]

{ #category : #specs }
PBUnloadProjectDialog >> withDependentsSpec [

	^ SpecLayout composed 
		newColumn: [ :col |
			col
				newRow: [ :row |
					row 
						newColumn: #iconPanel width: 40;
						newColumn: #messageLabel] height: 40;
				newRow: [ :row | 
					row newColumn: [ :col2 |  ] width: 40.
					row newColumn: #removePackagesCheckBox ] height: 40;
				newRow: [ :row | row newColumn: #dependentsLabel];
				newRow: [ :row | row newColumn: #dependentsPanel];
				newRow: [ :row | ] height: 1]
]

{ #category : #specs }
PBUnloadProjectDialog >> withoutDependentsSpec [

	^ SpecLayout composed 
		newColumn: [ :col |
			col
				newRow: [ :row |
					row 
						newColumn: #iconPanel width: 40;
						newColumn: #messageLabel] height: 40;
				newRow: [ :row | 
					row newColumn: [ :col2 |  ] width: 40.
					row newColumn: #removePackagesCheckBox ] height: 35;
				newRow: [ :row | ] height: 1]
]
