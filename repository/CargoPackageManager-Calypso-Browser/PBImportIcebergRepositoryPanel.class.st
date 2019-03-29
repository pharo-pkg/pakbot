"
I am an option panel that lets the user select an already installed iceberg repository.
"
Class {
	#name : #PBImportIcebergRepositoryPanel,
	#superclass : #ComposablePresenter,
	#instVars : [
		'repositoryList'
	],
	#category : #'CargoPackageManager-Calypso-Browser-Dialogs'
}

{ #category : #specs }
PBImportIcebergRepositoryPanel class >> defaultSpec [
	<spec: #default>

	^ SpecLayout composed 
		newColumn: [ :col | col add: #repositoryList ]
]

{ #category : #accepting }
PBImportIcebergRepositoryPanel >> accept [
	
	^ repositoryList selectedItem
]

{ #category : #specs }
PBImportIcebergRepositoryPanel >> icon [
	^ self iconNamed: #komitterSmalltalkhubRemote
]

{ #category : #initialization }
PBImportIcebergRepositoryPanel >> initializePresenter [
	
	repositoryList items: (IceLibgitRepository registry sorted: [ :a :b | a name asUppercase < b name asUppercase ]).
]

{ #category : #initialization }
PBImportIcebergRepositoryPanel >> initializeWidgets [
	
	repositoryList := self newList.
	repositoryList displayBlock: [ :each | each name ]
]

{ #category : #accessing }
PBImportIcebergRepositoryPanel >> newRepository [ 
	"polymorphic with other iceberg creation panels"
	^ repositoryList selectedItem
]

{ #category : #accessing }
PBImportIcebergRepositoryPanel >> repositoryList [
	^ repositoryList
]

{ #category : #accessing }
PBImportIcebergRepositoryPanel >> repositoryList: anObject [
	repositoryList := anObject
]

{ #category : #specs }
PBImportIcebergRepositoryPanel >> title [
	^ 'Existing Iceberg Repository'
]

{ #category : #accepting }
PBImportIcebergRepositoryPanel >> validate [ 	
	"We import an existing repository => no validation"
]
