"
Abstract class showing a list of packages and allowing to add/remove/edit elements from the list
"
Class {
	#name : #CGOPackageListEditor,
	#superclass : #PBLoadableUnitPanel,
	#instVars : [
		'ongoingPackageVersion',
		'packageTree',
		'label',
		'addButton',
		'editButton',
		'removeButton'
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

{ #category : #'instance creation' }
CGOPackageListEditor class >> newOn: anOngoingPackageVersion owner: owner [
	^ self basicNew
		owner: owner;
		initializeWith: anOngoingPackageVersion;
		yourself
]

{ #category : #opening }
CGOPackageListEditor class >> openOn: anOngoingPackageVersion [
	(self newOn: anOngoingPackageVersion owner: nil)
		openWithSpec
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
CGOPackageListEditor >> ballonTextFor: aPart [

	aPart isInstalled ifFalse: [ ^ 'The dependency is not installed in the system' ].
	^ nil
]

{ #category : #'private - displaying' }
CGOPackageListEditor >> displayFor: aDependency [

	^ aDependency displayString asMorph
		setBalloonText: (self ballonTextFor: aDependency);
		yourself
]

{ #category : #accessing }
CGOPackageListEditor >> editButton [
	^ editButton
]

{ #category : #'private - displaying' }
CGOPackageListEditor >> iconForPackage: aDependency [

	aDependency isInstalled ifFalse: [ ^ self notInstalledIcon ].	
	^ self unitIcon
	"^ (ongoingPackageVersion project packageUnitNames includes: part targetedPackage)
		ifTrue: [ self unitIcon ]
		ifFalse: [ (ongoingPackageVersion project virtualPackages anySatisfy: [ :virtual | virtual packageName = part targetedPackage ])
			ifTrue: [ self virtualPackageIcon ]
			ifFalse: [ self assemblyIcon ] ]"
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

{ #category : #initialization }
CGOPackageListEditor >> initializeWith: anOngoingPackageUnit [
	ongoingPackageVersion := anOngoingPackageUnit.
	self initialize
]

{ #category : #accessing }
CGOPackageListEditor >> label [
	^ label
]

{ #category : #'private - displaying' }
CGOPackageListEditor >> morphIconFor: aPart [

	^ (self iconForPackage: aPart) asMorph
		 setBalloonText: (self ballonTextFor: aPart)
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
	
	removeButton enabled: ann newSelectedRowIndexes notEmpty.
	editButton enabled: ann newSelectedRowIndexes notEmpty.

]

{ #category : #'private - displaying' }
CGOPackageListEditor >> unitIcon [
	^ self iconNamed: #packageIcon
]

{ #category : #'private - displaying' }
CGOPackageListEditor >> virtualPackageIcon [
	^ self iconNamed: #image
]
