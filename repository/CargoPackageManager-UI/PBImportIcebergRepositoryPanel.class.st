"
I am an option panel that lets the user select an already installed iceberg repository.
"
Class {
	#name : #PBImportIcebergRepositoryPanel,
	#superclass : #SpOptionPresenter,
	#instVars : [
		'repositoryList'
	],
	#category : #'CargoPackageManager-UI'
}

{ #category : #accepting }
PBImportIcebergRepositoryPanel >> accept [
	
	^ repositoryList selectedItem
]

{ #category : #initialization }
PBImportIcebergRepositoryPanel >> connectPresenters [

	repositoryList items:
		(IceLibgitRepository registry sorted: [ :a :b | 
			 a name asUppercase < b name asUppercase ])
]

{ #category : #layout }
PBImportIcebergRepositoryPanel >> defaultLayout [

	^ SpBoxLayout newTopToBottom 
		add: repositoryList;
		yourself
]

{ #category : #initialization }
PBImportIcebergRepositoryPanel >> initializePresenters [
	
	repositoryList := self newList.
	repositoryList display: [ :each | each name ]
]

{ #category : #accessing }
PBImportIcebergRepositoryPanel >> newRepository [ 
	"polymorphic with other iceberg creation panels"
	^ repositoryList selectedItem
]

{ #category : #specs }
PBImportIcebergRepositoryPanel >> optionIcon [
	^ self iconNamed: #komitterSmalltalkhubRemote
]

{ #category : #specs }
PBImportIcebergRepositoryPanel >> optionTitle [ 
	^ 'Existing Iceberg Repository'
]

{ #category : #accessing }
PBImportIcebergRepositoryPanel >> repositoryList [
	^ repositoryList
]

{ #category : #accessing }
PBImportIcebergRepositoryPanel >> repositoryList: anObject [
	repositoryList := anObject
]

{ #category : #accepting }
PBImportIcebergRepositoryPanel >> validate [ 	
	"We import an existing repository => no validation"
]
