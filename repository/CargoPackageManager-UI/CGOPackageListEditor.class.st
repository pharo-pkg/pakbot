"
Abstract class showing a list of packages and allowing to add/remove/edit elements from the list
"
Class {
	#name : #CGOPackageListEditor,
	#superclass : #PBLoadableUnitPanel,
	#instVars : [
		'label',
		'addButton',
		'editButton',
		'removeButton',
		'packageList'
	],
	#category : #'CargoPackageManager-UI'
}

{ #category : #specs }
CGOPackageListEditor class >> defaultSpec [
	^ SpecLayout composed
		newColumn: [ :column |
			column 
				newRow: [ :toolbar |
					toolbar
						add: #label;
						add: #addButton;
						add: #editButton;
						add: #removeButton ]
				height: self toolbarHeight;
				add: #packageTree ]

]

{ #category : #accessing }
CGOPackageListEditor >> addButton [
	^ addButton
]

{ #category : #'private - displaying' }
CGOPackageListEditor >> assemblyIcon [
	^ self iconNamed: #groupIcon
]

{ #category : #'private - displaying' }
CGOPackageListEditor >> displayFor: aDependency [

	^ aDependency displayString asMorph
		setBalloonText: aDependency balloonText;
		yourself
]

{ #category : #accessing }
CGOPackageListEditor >> editButton [
	^ editButton
]

{ #category : #'private - displaying' }
CGOPackageListEditor >> iconForPackage: aDependency [

	^ self iconNamed: aDependency statusIconName.

]

{ #category : #initialization }
CGOPackageListEditor >> initializePresenter [
	super initializePresenter.
	packageTree widget onAnnouncement: FTSelectionChanged send: #selectionChanged: to: self.
	addButton action: [ self addAction ].
	removeButton
		action: [ self removeAction: self selectedPackage.
			self refreshUI ].
	editButton action: [ self editAction ]
]

{ #category : #initialization }
CGOPackageListEditor >> initializeTable [

	packageTree widget dataSource: self newDataSource
]

{ #category : #initialization }
CGOPackageListEditor >> initializeWidgets [
	(label := self newLabel) label: self packageListEditorLabel.
	addButton := self newButton
		label: nil;
		icon: (self iconNamed: #addIcon);
		enabled: true;
		help: self addButtonHelpString.
	editButton := self newButton
		label: nil;
		icon: (self iconNamed: #editIcon);
		enabled: false;
		help: self editButtonHelpString.
	removeButton := self newButton
		label: nil;
		icon: (self iconNamed: #removeIcon);
		enabled: false;
		help: self removeButtonHelpString.
	packageTree := self newFastTable.
	self initializeTable

]

{ #category : #accessing }
CGOPackageListEditor >> label [
	^ label
]

{ #category : #'private - displaying' }
CGOPackageListEditor >> morphIconFor: aPart [

	^ (self iconForPackage: aPart) asMorph
		 setBalloonText: aPart balloonText
]

{ #category : #datasource }
CGOPackageListEditor >> newDataSource [
	
	^ FTEasyListDataSource new 
		elements: self buildRoots;
		display: [ :each | self displayFor: each ];
		icon: [ :each | self morphIconFor: each ];
		yourself
]

{ #category : #'private - displaying' }
CGOPackageListEditor >> notInstalledIcon [
	
	^ self iconNamed: #error
]

{ #category : #accessing }
CGOPackageListEditor >> packageTree [
	^ packageTree
]

{ #category : #refreshing }
CGOPackageListEditor >> refreshUI [
	packageTree widget dataSource: self newDataSource.

]

{ #category : #accessing }
CGOPackageListEditor >> removeButton [
	^ removeButton
]

{ #category : #accessing }
CGOPackageListEditor >> selectedPackage [
	| selectedIndex |
	selectedIndex := packageTree widget selectedRowIndex.
	selectedIndex = 0 ifTrue: [ ^ nil ].
	
	^ packageTree widget dataSource elementAt: selectedIndex
]

{ #category : #initialization }
CGOPackageListEditor >> selectionChanged: ann [
	removeButton enabled: ann newSelectedIndexes notEmpty.
	editButton enabled: ann newSelectedIndexes notEmpty
]

{ #category : #initialization }
CGOPackageListEditor >> setModelBeforeInitialization: aModel [
	ongoingPackageVersion := aModel
]

{ #category : #'private - displaying' }
CGOPackageListEditor >> virtualPackageIcon [
	^ self iconNamed: #image
]
