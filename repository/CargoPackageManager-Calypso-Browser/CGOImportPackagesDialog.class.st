"
I am a dialog that allows to select a set of packages coming from the system. On accept, those packages are added to the configured model.
"
Class {
	#name : #CGOImportPackagesDialog,
	#superclass : #ComposablePresenter,
	#instVars : [
		'model',
		'packagesList',
		'packageNameText',
		'acceptButton',
		'cancelButton'
	],
	#category : 'CargoPackageManager-Calypso-Browser'
}

{ #category : #specs }
CGOImportPackagesDialog class >> defaultSpec [
	<spec: #default>
	
	^ SpecLayout composed 
		newColumn: [ :column |
			column 
				newRow: #packagesList;
				newRow: #packageNameText height: self inputTextHeight ]
]

{ #category : #accessing }
CGOImportPackagesDialog class >> icon [
	^ self iconNamed: #branch
]

{ #category : #accessing }
CGOImportPackagesDialog class >> order [
	^ 20
]

{ #category : #specs }
CGOImportPackagesDialog class >> title [
	^ 'Add packages'
]

{ #category : #actions }
CGOImportPackagesDialog >> accept [
	| items |
	
	"ensure window goes away (in case accept comes from a keybinding and not the ok button)"
	self window delete. 
	
	items := self packagesList widget dataSource selectedItems.
	items ifEmpty: [ 
		UIManager default inform: 'No packages selected.'.
		^ self ].
	
	items do: [ :each |
		self model importPackageNamed: each name ]
]

{ #category : #initialization }
CGOImportPackagesDialog >> addShortcutsTo: aWidget [
	super addShortcutsTo: aWidget.
	aWidget 
		bindKeyCombination: Character cr asKeyCombination 
		toAction: [ self accept ].
	
]

{ #category : #accessing }
CGOImportPackagesDialog >> allPackages [
	^ RPackageOrganizer default packages
		asOrderedCollection 
		sort: [ :a :b | a name < b name ]
]

{ #category : #accessing }
CGOImportPackagesDialog >> allPackagesNotRegistered [
	| currentPackagesNames |
	currentPackagesNames := self model packages collect: #packageName.
	^ self allPackages reject: [ :rPackage | currentPackagesNames includes: rPackage name ]
]

{ #category : #accessing }
CGOImportPackagesDialog >> contextSelection [ 
	^ self selectedPackage
]

{ #category : #initialization }
CGOImportPackagesDialog >> initializeDialogWindow: aWindow [
	acceptButton := aWindow toolbar okButton.
	cancelButton := aWindow toolbar cancelButton.
	acceptButton
		disable;
		label: 'Add'
]

{ #category : #initialization }
CGOImportPackagesDialog >> initializePackageNameText [
	self packageNameText whenBuiltDo: [ :ann |
		ann widget 
			bindKeyCombination: Character enter asKeyCombination 
				toAction: [ self accept ];
			bindKeyCombination: Character arrowUp asKeyCombination 
				toAction: [ 
					self packagesList takeKeyboardFocus.
					self packagesList widget selectLastVisibleRow ];
			bindKeyCombination: Character arrowDown asKeyCombination 
				toAction: [ 
					self packagesList takeKeyboardFocus.
					self packagesList widget selectFirstVisibleRow ] ]
]

{ #category : #initialization }
CGOImportPackagesDialog >> initializePackagesList [
	| dataSource |
	
	dataSource := self newPackagesListDataSource.
	packagesList widget
		addColumn: (IceTipTableColumn newAction: #name icon: [ :each | self iconNamed: #package ]);
		dataSource: dataSource;
		useFunction: IceTipLinkFilterFunction do: [ :function | 
			function 
				filterClass: IceTipPackageFilter;
				textField: self packageNameText ];
		bindKeyCombination: Character cr toAction: [ self accept ];
		onAnnouncement: FTStrongSelectionChanged do: [ self accept ]
]

{ #category : #initialization }
CGOImportPackagesDialog >> initializeWidgets [
	packagesList := self newIceTreeTable.
	packageNameText := self newTextInput 
		autoAccept: true;
		ghostText: 'e.g., Collections'.
	
	self initializePackagesList.
	self initializePackageNameText.
	
	self focusOrder 
		add: self packagesList;
		add: self packageNameText
]

{ #category : #accessing }
CGOImportPackagesDialog >> model [
	^ model
]

{ #category : #accessing }
CGOImportPackagesDialog >> model: anObject [
	model := anObject.
	self refresh
]

{ #category : #'private factory' }
CGOImportPackagesDialog >> newPackagesListDataSource [
	| dataSource |
	^ (dataSource := IceTipSelectingDataSource new)
		tool: self;
		elements: self allPackagesNotRegistered;
		onSelectionChangedBlock: [ :item :wasSelected | wasSelected ifTrue: [ acceptButton enable ] ifFalse: [ dataSource selectedItems ifEmpty: [ acceptButton disable ] ] ];
		yourself
]

{ #category : #accessing }
CGOImportPackagesDialog >> openDialogWithSpec [
	^ super openDialogWithSpec
		okAction: [ self accept ];
		yourself
]

{ #category : #accessing }
CGOImportPackagesDialog >> packageNameText [
	^ packageNameText
]

{ #category : #accessing }
CGOImportPackagesDialog >> packageNameText: anObject [
	packageNameText := anObject
]

{ #category : #accessing }
CGOImportPackagesDialog >> packagesList [
	^ packagesList
]

{ #category : #accessing }
CGOImportPackagesDialog >> packagesList: anObject [
	packagesList := anObject
]

{ #category : #accessing }
CGOImportPackagesDialog >> refresh [
	packagesList widget 
		in: [ :this | 
			this selectRowIndexes: #(). 
			this dataSource 
				rootForItems: self model repositoryModelsByGroup;
				expandAll ];
		refresh.
]

{ #category : #accessing }
CGOImportPackagesDialog >> selectedPackage [
	| index |
	self flag: #todo. "This should -maybe- be modeled better on a SpecTablePresenter ;)"
	index := packagesList widget selectedRowIndex.
	index = 0 ifTrue: [ ^ nil ].
	^ packagesList widget dataSource elementAt: index
]

{ #category : #initialization }
CGOImportPackagesDialog >> setModelBeforeInitialization: anObject [ 
	model := anObject
]

{ #category : #accessing }
CGOImportPackagesDialog >> validate [
	self 
		assert: self selectedPackage isNotNil 
		description: 'Please select a branch to checkout.'
]

{ #category : #'private factory' }
CGOImportPackagesDialog >> withAssertHandlingDo: aBlock [
	^ aBlock 
		on: AssertionFailure 
		do: [ :e | 
			UIManager default 
				alert: e messageText
				title: 'Error: ', self title .
			^ false ]
]
