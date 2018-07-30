Class {
	#name : #PBSelectPackagesDialog,
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
PBSelectPackagesDialog class >> defaultSpec [
	<spec: #default>
	
	^ SpecLayout composed 
		newColumn: [ :column |
			column 
				newRow: #packagesList;
				newRow: #packageNameText height: self inputTextHeight ]
]

{ #category : #accessing }
PBSelectPackagesDialog class >> icon [
	^ self iconNamed: #branch
]

{ #category : #accessing }
PBSelectPackagesDialog class >> order [
	^ 20
]

{ #category : #specs }
PBSelectPackagesDialog class >> title [
	^ 'Add packages'
]

{ #category : #actions }
PBSelectPackagesDialog >> accept [
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
PBSelectPackagesDialog >> addShortcutsTo: aWidget [
	super addShortcutsTo: aWidget.
	aWidget 
		bindKeyCombination: Character cr asKeyCombination 
		toAction: [ self accept ].
	
]

{ #category : #accessing }
PBSelectPackagesDialog >> allPackages [
	^ RPackageOrganizer default packages
		asOrderedCollection 
		sort: [ :a :b | a name < b name ]
]

{ #category : #initialization }
PBSelectPackagesDialog >> initializeDialogWindow: aWindow [
	acceptButton := aWindow toolbar okButton.
	cancelButton := aWindow toolbar cancelButton.
	acceptButton
		disable;
		label: 'Add'
]

{ #category : #initialization }
PBSelectPackagesDialog >> initializePackageNameText [
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
PBSelectPackagesDialog >> initializePackagesList [
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
PBSelectPackagesDialog >> initializeWidgets [
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
PBSelectPackagesDialog >> model [
	^ model
]

{ #category : #accessing }
PBSelectPackagesDialog >> model: anObject [
	model := anObject.
	self refresh
]

{ #category : #'private factory' }
PBSelectPackagesDialog >> newPackagesListDataSource [
	| dataSource |
	^ (dataSource := IceTipSelectingDataSource new)
		tool: self;
		elements: model;
		onSelectionChangedBlock: [ :item :wasSelected | wasSelected ifTrue: [ acceptButton enable ] ifFalse: [ dataSource selectedItems ifEmpty: [ acceptButton disable ] ] ];
		yourself
]

{ #category : #accessing }
PBSelectPackagesDialog >> openDialogWithSpec [
	^ super openDialogWithSpec
		okAction: [ self accept ];
		yourself
]

{ #category : #accessing }
PBSelectPackagesDialog >> packageNameText [
	^ packageNameText
]

{ #category : #accessing }
PBSelectPackagesDialog >> packageNameText: anObject [
	packageNameText := anObject
]

{ #category : #accessing }
PBSelectPackagesDialog >> packagesList [
	^ packagesList
]

{ #category : #accessing }
PBSelectPackagesDialog >> packagesList: anObject [
	packagesList := anObject
]

{ #category : #accessing }
PBSelectPackagesDialog >> refresh [
	packagesList widget 
		in: [ :this | 
			this selectRowIndexes: #(). 
			this dataSource 
				rootForItems: self model repositoryModelsByGroup;
				expandAll ];
		refresh.
]

{ #category : #accessing }
PBSelectPackagesDialog >> selectedItems [

	^ self packagesList widget dataSource selectedItems
]

{ #category : #initialization }
PBSelectPackagesDialog >> setModelBeforeInitialization: anObject [ 
	model := anObject
]

{ #category : #'private factory' }
PBSelectPackagesDialog >> withAssertHandlingDo: aBlock [
	^ aBlock 
		on: AssertionFailure 
		do: [ :e | 
			UIManager default 
				alert: e messageText
				title: 'Error: ', self title .
			^ false ]
]
