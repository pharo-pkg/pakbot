"
A small UI to search published projects and their available versions
"
Class {
	#name : #PBPackageRepositoryPresenter,
	#superclass : #SpPresenterWithModel,
	#instVars : [
		'projectList',
		'versionList'
	],
	#category : #'Pakbot-Browser-Repository'
}

{ #category : #initialization }
PBPackageRepositoryPresenter >> connectPresenters [

	projectList
		transmitTo: versionList
		transform: [ :projectName | self repository versionsOf: projectName ]
]

{ #category : #layout }
PBPackageRepositoryPresenter >> defaultLayout [ 

	^ SpBoxLayout newLeftToRight
		spacing: 10;
		add: projectList;
		add: versionList;
		yourself
]

{ #category : #initialization }
PBPackageRepositoryPresenter >> initializePresenters [ 
	projectList := self newFilteringList
		items: self repository packages;
		yourself.
		
	
	versionList := self newFilteringList.
]

{ #category : #initialization }
PBPackageRepositoryPresenter >> initializeWindow: aWindowPresenter [

	aWindowPresenter
		title: 'Pakbot repository browser';
		initialExtent: 500@300
]

{ #category : #accessing }
PBPackageRepositoryPresenter >> repository [
	^ self model
]
