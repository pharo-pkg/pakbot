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
			postActionCallback: [ self modelChanged ];
			execute ].
]

{ #category : #layout }
PBRepositoryPresenter >> defaultLayout [

	^ SpBoxLayout newLeftToRight 
			add: #icon expand: false;
			add: #label;
			add: #button expand: false;
			yourself
]

{ #category : #initialization }
PBRepositoryPresenter >> initializePresenters [
	
	icon := self newImage.
	label := self newLabel.
	button := self newButton.
]

{ #category : #initialization }
PBRepositoryPresenter >> modelChanged [ 

	icon image: (self iconNamed: self repository iconName).
	label label: self repository description.
	button iconName: self repository editionIconName.
]

{ #category : #accessing }
PBRepositoryPresenter >> project [
	^ self model
]

{ #category : #accessing }
PBRepositoryPresenter >> repository [
	^ self project 
		ifNil: [ PBNoRepository new ]
		ifNotNil: [ self project repository ]

]
