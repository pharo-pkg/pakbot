"
I am an option panel that lets the user select an already installed iceberg repository.
"
Class {
	#name : #PBImportIcebergRepositoryPresenter,
	#superclass : #SpOptionPresenter,
	#instVars : [
		'repositoryList'
	],
	#category : #'Pakbot-Browser-Presenters'
}

{ #category : #accepting }
PBImportIcebergRepositoryPresenter >> accept [
	
	^ repositoryList selectedItem
]

{ #category : #initialization }
PBImportIcebergRepositoryPresenter >> connectPresenters [

	repositoryList items:
		(IceLibgitRepository registry sorted: [ :a :b | 
			 a name asUppercase < b name asUppercase ])
]

{ #category : #layout }
PBImportIcebergRepositoryPresenter >> defaultLayout [

	^ SpBoxLayout newTopToBottom 
		add: repositoryList;
		yourself
]

{ #category : #initialization }
PBImportIcebergRepositoryPresenter >> initializePresenters [
	
	repositoryList := self newList.
	repositoryList display: [ :each | each name ]
]

{ #category : #accessing }
PBImportIcebergRepositoryPresenter >> newRepository [ 
	"polymorphic with other iceberg creation panels"
	^ repositoryList selectedItem
]

{ #category : #specs }
PBImportIcebergRepositoryPresenter >> optionIcon [
	^ self iconNamed: #komitterSmalltalkhubRemote
]

{ #category : #specs }
PBImportIcebergRepositoryPresenter >> optionTitle [ 
	^ 'Existing Iceberg Repository'
]

{ #category : #accessing }
PBImportIcebergRepositoryPresenter >> repositoryList [
	^ repositoryList
]

{ #category : #accessing }
PBImportIcebergRepositoryPresenter >> repositoryList: anObject [
	repositoryList := anObject
]

{ #category : #accepting }
PBImportIcebergRepositoryPresenter >> validate [ 	
	"We import an existing repository => no validation"
]
