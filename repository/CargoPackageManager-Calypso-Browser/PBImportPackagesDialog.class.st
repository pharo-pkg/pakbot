"
I am a dialog that allows to select a set of packages coming from the system. On accept, those packages are added to the configured model.
"
Class {
	#name : #PBImportPackagesDialog,
	#superclass : #ComposablePresenter,
	#instVars : [
		'model',
		'packagesList',
		'packageNameText',
		'acceptButton',
		'cancelButton'
	],
	#category : #'CargoPackageManager-Calypso-Browser-Dialogs'
}

{ #category : #specs }
PBImportPackagesDialog class >> defaultSpec [
	<spec: #default>
	
	^ SpecLayout composed 
		newColumn: [ :column |
			column 
				newRow: #packagesList;
				newRow: #packageNameText height: self inputTextHeight ]
]

{ #category : #accessing }
PBImportPackagesDialog class >> icon [
	^ self iconNamed: #branch
]

{ #category : #accessing }
PBImportPackagesDialog class >> order [
	^ 20
]

{ #category : #specs }
PBImportPackagesDialog class >> title [
	^ 'Add packages'
]

{ #category : #actions }
PBImportPackagesDialog >> accept [
	"ensure window goes away (in case accept comes from a keybinding and not the ok button)"
	self window delete.
]

{ #category : #initialization }
PBImportPackagesDialog >> addShortcutsTo: aWidget [
	super addShortcutsTo: aWidget.
	aWidget 
		bindKeyCombination: Character cr asKeyCombination 
		toAction: [ self accept ].
	
]

{ #category : #accessing }
PBImportPackagesDialog >> allPackages [
	^ RPackageOrganizer default packages
		asOrderedCollection 
		sort: [ :a :b | a name < b name ]
]

{ #category : #accessing }
PBImportPackagesDialog >> allPackagesNotRegistered [
	| currentPackagesNames |
	currentPackagesNames := self model packages collect: #name.
	^ self allPackages reject: [ :rPackage | currentPackagesNames includes: rPackage name ]
]

{ #category : #accessing }
PBImportPackagesDialog >> contextSelection [ 
	^ self selectedPackage
]

{ #category : #initialization }
PBImportPackagesDialog >> initializeDialogWindow: aWindow [
	acceptButton := aWindow toolbar okButton.
	cancelButton := aWindow toolbar cancelButton.
	acceptButton
		disable;
		label: 'Add'
]

{ #category : #initialization }
PBImportPackagesDialog >> initializePackageNameText [
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
PBImportPackagesDialog >> initializePackagesList [
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
PBImportPackagesDialog >> initializeWidgets [
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
PBImportPackagesDialog >> model [
	^ model
]

{ #category : #accessing }
PBImportPackagesDialog >> model: anObject [
	model := anObject.
	self refresh
]

{ #category : #'private factory' }
PBImportPackagesDialog >> newPackagesListDataSource [
	| dataSource |
	^ (dataSource := IceTipSelectingDataSource new)
		tool: self;
		elements: self allPackagesNotRegistered;
		onSelectionChangedBlock: [ :item :wasSelected | wasSelected ifTrue: [ acceptButton enable ] ifFalse: [ dataSource selectedItems ifEmpty: [ acceptButton disable ] ] ];
		yourself
]

{ #category : #accessing }
PBImportPackagesDialog >> openDialogWithSpec [
	^ super openDialogWithSpec
		okAction: [ self accept ];
		yourself
]

{ #category : #accessing }
PBImportPackagesDialog >> packageNameText [
	^ packageNameText
]

{ #category : #accessing }
PBImportPackagesDialog >> packageNameText: anObject [
	packageNameText := anObject
]

{ #category : #accessing }
PBImportPackagesDialog >> packagesList [
	^ packagesList
]

{ #category : #accessing }
PBImportPackagesDialog >> packagesList: anObject [
	packagesList := anObject
]

{ #category : #accessing }
PBImportPackagesDialog >> refresh [
	packagesList widget 
		in: [ :this | 
			this selectRowIndexes: #(). 
			this dataSource 
				rootForItems: self model repositoryModelsByGroup;
				expandAll ];
		refresh.
]

{ #category : #accessing }
PBImportPackagesDialog >> selectedPackage [
	| index |
	self flag: #todo. "This should -maybe- be modeled better on a SpecTablePresenter ;)"
	index := packagesList widget selectedRowIndex.
	index = 0 ifTrue: [ ^ nil ].
	^ packagesList widget dataSource elementAt: index
]

{ #category : #initialization }
PBImportPackagesDialog >> setModelBeforeInitialization: anObject [ 
	model := anObject
]

{ #category : #accessing }
PBImportPackagesDialog >> validate [
	self 
		assert: self selectedPackage isNotNil 
		description: 'Please select a branch to checkout.'
]

{ #category : #'private factory' }
PBImportPackagesDialog >> withAssertHandlingDo: aBlock [
	^ aBlock 
		on: AssertionFailure 
		do: [ :e | 
			UIManager default 
				alert: e messageText
				title: 'Error: ', self title .
			^ false ]
]
