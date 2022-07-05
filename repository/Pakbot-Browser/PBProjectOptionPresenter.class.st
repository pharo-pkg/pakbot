"
Abstract presenter showing available options for a project action.
You can select an option and then proceed with the selected action.

You just need to provide a layout, a list of available options and the presenter is ready to be used.
"
Class {
	#name : #PBProjectOptionPresenter,
	#superclass : #SpPresenterWithModel,
	#instVars : [
		'optionList',
		'detailPanel'
	],
	#category : #'Pakbot-Browser-Presenters'
}

{ #category : #action }
PBProjectOptionPresenter >> accept [

	self closeWindow.
	self selectedOption execute.
]

{ #category : #accessing }
PBProjectOptionPresenter >> availableOptions [

	self subclassResponsibility
]

{ #category : #action }
PBProjectOptionPresenter >> cancel [

	self closeWindow
]

{ #category : #action }
PBProjectOptionPresenter >> closeWindow [

	self window close
]

{ #category : #initialization }
PBProjectOptionPresenter >> initializeDialogWindow: aWindow [

	super initializeDialogWindow: aWindow.

	aWindow 
		  okAction: [ self accept ];
		  cancelAction: [ self cancel ]; 
		  bindKeyCombination: Character escape asShortcut toAction: [ self cancel ].
]

{ #category : #initialization }
PBProjectOptionPresenter >> initializePresenters [ 

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
		items: self availableOptions;
		whenSelectionChangedDo: [ :selection | self selectionChanged ];
		whenActivatedDo: [ :selection | selection ifNotNil: [ self accept ] ];
		yourself.
		
	detailPanel := self newText
		beNotEditable;
		beWrapWord;
		addStyle: 'readonly';
		yourself.
		
	optionList selectFirst.

]

{ #category : #accessing }
PBProjectOptionPresenter >> project [
	
	^ self model
]

{ #category : #refreshing }
PBProjectOptionPresenter >> refreshDetailPanel [

	self selectedOption ifNotNil: [ :option |
		detailPanel
			text: option description;
			yourself ]
]

{ #category : #refreshing }
PBProjectOptionPresenter >> refreshDialogButtons [

	self window ifNotNil: [ :aWindow |
		aWindow buttons first enabled: (self selectedOption isNotNil) ]
]

{ #category : #accessing }
PBProjectOptionPresenter >> selectedOption [
	
	^ optionList selectedItem
]

{ #category : #refreshing }
PBProjectOptionPresenter >> selectionChanged [

	self refreshDetailPanel.
	self refreshDialogButtons.	

]
