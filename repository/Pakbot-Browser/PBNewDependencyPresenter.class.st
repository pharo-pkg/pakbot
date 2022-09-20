"
I'm a presenter used to add a new dependency to a Pakbot project.
I use an option list presenter with 3 options:
- metacello baseline dependency
- metacello configuration dependency
- pakbot dependency
"
Class {
	#name : #PBNewDependencyPresenter,
	#superclass : #SpOptionListPresenter,
	#category : #'Pakbot-Browser-Presenters-Dependencies'
}

{ #category : #examples }
PBNewDependencyPresenter class >> example [
	<example>
	self new openDialog
]

{ #category : #initialization }
PBNewDependencyPresenter >> allOptions [

	^	{ PBPakbotDependencyPresenter .
		PBMetacelloBaselineDependencyPresenter .
		PBMetacelloConfigurationDependencyPanel }
		collect: [ :class | class newApplication: self application ]
]

{ #category : #initialization }
PBNewDependencyPresenter >> initialize [
	super initialize.
	
	self flag: 'TODO: add validation for ok button'
	"panels do: [ :aPanel | aPanel whenChangedDo: [ :p | self okEnabled: p isValid  ]]"
]

{ #category : #initialization }
PBNewDependencyPresenter >> initializeDialogWindow: aDialogWindowPresenter [

	super initializeDialogWindow: aDialogWindowPresenter.		
	aDialogWindowPresenter okButton enabled: false.

]

{ #category : #initialization }
PBNewDependencyPresenter >> initializeWindow: aWindowPresenter [

	aWindowPresenter
		title: 'Add a dependency';
		initialExtent: 800@500.
]

{ #category : #opening }
PBNewDependencyPresenter >> openDialogOnAccept: acceptBlock onCancel: cancelBlock [
	
	^ self openDialog
		okAction: [
			self selectedOption updateDependency.
			acceptBlock cull: self selectedOption dependency ];
		cancelAction: [ cancelBlock cull: self ];
		yourself
]
