"
Presenter displaying both current resolution and potential conflits.
After conflicts are solved, proceed to the load action.
"
Class {
	#name : #PBLoadPreviewPresenter,
	#superclass : #SpPresenterWithModel,
	#instVars : [
		'resolutionPanel',
		'conflictsPanel'
	],
	#category : #'Pakbot-Browser-Presenters'
}

{ #category : #examples }
PBLoadPreviewPresenter class >> example [
	<example>

	(self on: PBResolutionPresenter conflictingResolutionExample) openDialog
]

{ #category : #visiting }
PBLoadPreviewPresenter >> accept [
	conflictsPanel accept.
	self resolution load
]

{ #category : #layout }
PBLoadPreviewPresenter >> defaultLayout [

	^ SpPanedLayout newLeftToRight 
		add: (SpBoxLayout newTopToBottom 
			add: 'Dependency resolution' expand: false;
			add: resolutionPanel;
			yourself);
		add: (SpBoxLayout newTopToBottom 
			add: 'Conflicts to solve' expand: false;
			add: conflictsPanel;
			yourself);
		positionOfSlider: 0.4;
		yourself
]

{ #category : #initialization }
PBLoadPreviewPresenter >> initializeDialogWindow: aWindow [

	super initializeDialogWindow: aWindow.

	aWindow
		title: 'Load Preview';
		initialExtent: 900@450;
		okAction: [ self accept ].
		
	self updateOkButton.
]

{ #category : #initialization }
PBLoadPreviewPresenter >> initializePresenters [ 

	conflictsPanel := PBConflictsPresenter on: self resolution.
	resolutionPanel := PBResolutionPresenter on: self resolution.
]

{ #category : #accessing }
PBLoadPreviewPresenter >> okButton [ 

	^ self window buttons detect: [ :each | each label = 'Ok' ]
]

{ #category : #accessing }
PBLoadPreviewPresenter >> resolution [

	^ self model
]

{ #category : #updating }
PBLoadPreviewPresenter >> updateOkButton [

	^ conflictsPanel hasConflicts
		ifTrue: [ self okButton disable ]
		ifFalse: [ self okButton enable ]
]

{ #category : #updating }
PBLoadPreviewPresenter >> updateResolutionPresenter [
	
	resolutionPanel updateResolutionTree.
]
