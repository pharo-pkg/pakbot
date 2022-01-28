"
I'm an input widget representing a Git repository.
I have a button allowing to change the repository URL either by selecting an existing repository (declared in Iceberg) or by creating a new one.
"
Class {
	#name : #PBRepositoryInputField,
	#superclass : #SpPresenterWithModel,
	#instVars : [
		'label',
		'button',
		'icon'
	],
	#category : #'CargoPackageManager-UI'
}

{ #category : #examples }
PBRepositoryInputField class >> example [
	<example>
	
	^ (self on: PBProjectVersion example) 
		openWithSpec
]

{ #category : #initialization }
PBRepositoryInputField >> connectPresenters [
	
	button action: [ 
		(PBOpenNewRepositoryDialogAction onProject: self project)
			postActionCallback: [ self refresh ];
			execute ].
		
	self refresh.
]

{ #category : #initialization }
PBRepositoryInputField >> initializeLayout [

	self layout: (SpBoxLayout newLeftToRight 
			add: #icon expand: false;
			add: #label;
			add: #button expand: false;
			yourself)
]

{ #category : #initialization }
PBRepositoryInputField >> initializePresenters [
	
	icon := self newImage.
	label := self newLabel.
	button := self newButton.
	
	self initializeLayout.

]

{ #category : #accessing }
PBRepositoryInputField >> project [
	^ self model
]

{ #category : #initialization }
PBRepositoryInputField >> refresh [

	| form repository |
	repository := self project repository.
	form := self iconNamed: repository iconName.
	
	icon image: form.
	label label: repository description.
	button iconName: repository editionIconName.
]
