"
I'm an input widget representing a Git repository.
I have a button allowing to change the repository URL either by selecting an existing repository (declared in Iceberg) or by creating a new one.
"
Class {
	#name : #PBRepositoryPresenter,
	#superclass : #SpPresenterWithModel,
	#instVars : [
		'label',
		'button',
		'icon'
	],
	#category : #'Pakbot-Browser-Presenters'
}

{ #category : #examples }
PBRepositoryPresenter class >> example [

	<example>
	^ (self on: PBProjectVersion example) open
]

{ #category : #initialization }
PBRepositoryPresenter >> connectPresenters [
	
	button action: [ 
		(PBOpenNewRepositoryDialogAction onProject: self project)
			postActionCallback: [ self refresh ];
			execute ].
]

{ #category : #initialization }
PBRepositoryPresenter >> initializeLayout [

	self layout: (SpBoxLayout newLeftToRight 
			add: #icon expand: false;
			add: #label;
			add: #button expand: false;
			yourself)
]

{ #category : #initialization }
PBRepositoryPresenter >> initializePresenters [
	
	icon := self newImage.
	label := self newLabel.
	button := self newButton.
	
	self initializeLayout.

]

{ #category : #accessing }
PBRepositoryPresenter >> project [
	^ self model
]

{ #category : #initialization }
PBRepositoryPresenter >> refresh [

	| form repository |
	repository := self project repository.
	form := self iconNamed: repository iconName.
	
	icon image: form.
	label label: repository description.
	button iconName: repository editionIconName.
]
