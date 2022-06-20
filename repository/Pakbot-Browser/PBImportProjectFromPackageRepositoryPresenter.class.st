"
I allow to import a Pakbot Project from a Pakbot package repository.
I will fetch the metadata of the project from the package repository but will not load the project.
"
Class {
	#name : #PBImportProjectFromPackageRepositoryPresenter,
	#superclass : #SpOptionPresenter,
	#instVars : [
		'repositoryUrlInputText',
		'packageList'
	],
	#category : #'Pakbot-Browser-Presenters-NewProject'
}

{ #category : #layout }
PBImportProjectFromPackageRepositoryPresenter >> defaultLayout [

	^ SpBoxLayout newTopToBottom 
		spacing: 5; 
		add: 'Package Repository Url:' expand: false;
		add: repositoryUrlInputText expand: false;
		add: 'Packages:' expand: false;
		add: packageList;
		yourself
]

{ #category : #actions }
PBImportProjectFromPackageRepositoryPresenter >> doAccept [

	| project |
	
	self flag: 'TODO'.
		
	project := self fetchSelectedProject ifNil: [ ^ self ].
	
	project registry: self application registry.
	"(PBLoadProjectDialog onProject: project) openDialog."
	^ project
]

{ #category : #actions }
PBImportProjectFromPackageRepositoryPresenter >> fetchSelectedProject [

	| project |
	packageList selectedItem ifNil: [ ^ nil ].
	project := packageList selectedItem.
	
	self packageRepository fetch: project name version: project version.
]

{ #category : #initialization }
PBImportProjectFromPackageRepositoryPresenter >> initializePresenters [ 
	
	repositoryUrlInputText := self newTextInput 
		placeholder: 'e.g., https://github.com/pharo-pkg/project-repository';
		yourself.
	
	packageList := self newList 
		items: self packageRepository packages;
		yourself.
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
