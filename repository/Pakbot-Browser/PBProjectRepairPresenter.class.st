"
Presenter showing available options to repair the project.
You can select an option and then proceed with the selected action.
"
Class {
	#name : #PBProjectRepairPresenter,
	#superclass : #SpPresenterWithModel,
	#instVars : [
		'reasonPanel',
		'optionList',
		'detailPanel'
	],
	#category : #'Pakbot-Browser-Presenters'
}

{ #category : #examples }
PBProjectRepairPresenter class >> example [
	
	(self on: PBProjectVersion exampleWithDependency) 
		application: PakbotBrowser new;
		openDialog
]

{ #category : #action }
PBProjectRepairPresenter >> accept [

	self closeWindow.
	self selectedOption execute.
]

{ #category : #accessing }
PBProjectRepairPresenter >> availableRepairOptions [
	
	^ PBRepairProjectAction allAvailableFor: self project
]

{ #category : #action }
PBProjectRepairPresenter >> cancel [

	self closeWindow
]

{ #category : #action }
PBProjectRepairPresenter >> closeWindow [

	self window close
]

{ #category : #layout }
PBProjectRepairPresenter >> defaultLayout [ 
	^ SpBoxLayout newTopToBottom 
		add: reasonPanel height: 70;
		add: optionList;
		add: detailPanel;
		yourself
]

{ #category : #initialization }
PBProjectRepairPresenter >> initializeDialogWindow: aWindow [

	super initializeDialogWindow: aWindow.

	aWindow 
		  okAction: [ self accept ];
		  cancelAction: [ self cancel ]; 
		  bindKeyCombination: Character escape asShortcut toAction: [ self cancel ].
]

{ #category : #initialization }
PBProjectRepairPresenter >> initializePresenters [ 
	reasonPanel := self newText
		beNotEditable;
		addStyle: 'readonly';
		beWrapWord;
		text: self project problemLongDescription;
		yourself.
		
	optionList := self newTable
		disable;
		hideColumnHeaders;
		addColumn: (SpCompositeTableColumn new
			addColumn: (SpImageTableColumn new
				width: 20;
				evaluated: [ :option | self iconNamed: option iconName ];
				yourself);
			addColumn: (SpStringTableColumn new
				evaluated: [ :option | option name ];
				yourself);
			yourself);
		items: self availableRepairOptions;
		whenSelectionChangedDo: [ :selection | self selectionChanged ];
		whenActivatedDo: [ :selection | selection ifNotNil: [ self accept ] ];
		yourself.
		
	detailPanel := self newText
		beNotEditable;
		beWrapWord;
		addStyle: 'readonly';
		yourself.

]

{ #category : #initialization }
PBProjectRepairPresenter >> initializeWindow: aWindowPresenter [

	super initializeWindow: aWindowPresenter.
	aWindowPresenter
		title: 'Repair Cargo Project';
		initialExtent:  700@500

]

{ #category : #accessing }
PBProjectRepairPresenter >> project [
	
	^ self model
]

{ #category : #refreshing }
PBProjectRepairPresenter >> refreshDetailPanel [

	self selectedOption ifNotNil: [ :option |
		detailPanel
			text: option description;
			yourself ]
]

{ #category : #refreshing }
PBProjectRepairPresenter >> refreshDialogButtons [

	self window ifNotNil: [ :aWindow |
		aWindow buttons first enabled: (self selectedOption isNotNil) ]
]

{ #category : #accessing }
PBProjectRepairPresenter >> selectedOption [
	
	^ optionList selectedItem
]

{ #category : #refreshing }
PBProjectRepairPresenter >> selectionChanged [

	self refreshDetailPanel.
	self refreshDialogButtons.	

]
