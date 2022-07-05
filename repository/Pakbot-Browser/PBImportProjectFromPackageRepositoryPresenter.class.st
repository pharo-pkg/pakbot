"
I allow to import a Pakbot Project from a Pakbot package repository.
I will fetch the metadata of the project from the package repository but will not load the project.
"
Class {
	#name : #PBImportProjectFromPackageRepositoryPresenter,
	#superclass : #SpOptionPresenter,
	#instVars : [
		'repositoryUrlInputText',
		'packageList',
		'versionList'
	],
	#category : #'Pakbot-Browser-Presenters-NewProject'
}

{ #category : #initialization }
PBImportProjectFromPackageRepositoryPresenter >> connectPresenters [

	packageList
		transmitTo: versionList
		transform: [ :projectName | self packageRepository versionsFor: projectName ]
]

{ #category : #layout }
PBImportProjectFromPackageRepositoryPresenter >> defaultLayout [

	^ SpBoxLayout newTopToBottom 
		spacing: 5; 
		add: 'Package Repository Url:' expand: false;
		add: repositoryUrlInputText expand: false;
		add: (SpBoxLayout newLeftToRight
			spacing: 10;
			add: (SpBoxLayout newTopToBottom 
				add: 'Projects:' expand: false;
				add: packageList;
				yourself);
			add: (SpBoxLayout newTopToBottom 
				add: 'Versions:' expand: false;
				add: versionList;
				yourself);
			yourself);
		yourself
]

{ #category : #actions }
PBImportProjectFromPackageRepositoryPresenter >> doAccept [

	| project |
	
	project := self fetchSelectedProject ifNil: [ ^ self ].
	
	project registry: self application registry.
	(PBLoadProjectPresenter on: project) 
		application: self application;
		openDialog.
	^ project
]

{ #category : #actions }
PBImportProjectFromPackageRepositoryPresenter >> fetchSelectedProject [

	packageList selectedItem ifNil: [ ^ nil ].
	versionList selectedItem ifNil: [ ^ nil ].

	^ self packageRepository
		  fetch: packageList selectedItem
		  version: versionList selectedItem
]

{ #category : #initialization }
PBImportProjectFromPackageRepositoryPresenter >> initializePresenters [ 
	
	repositoryUrlInputText := self newTextInput 
		placeholder: 'e.g., https://github.com/pharo-pkg/project-repository';
		yourself.
	
	packageList := self newList 
		items: self packageRepository packages;
		yourself.
		
	versionList := self newList.
]

{ #category : #'option list presenter' }
PBImportProjectFromPackageRepositoryPresenter >> optionIcon [

	^ self iconNamed: #catalog
]

{ #category : #'option list presenter' }
PBImportProjectFromPackageRepositoryPresenter >> optionTitle [

	^ 'Import from Repository'
]

{ #category : #initialization }
PBImportProjectFromPackageRepositoryPresenter >> packageRepository [
	
	^ self application packageRepository
]
