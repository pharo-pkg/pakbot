"
I allow to import a Pakbot Project from a Git repository.
I will fetch the metadata of the project from the Git repository but will not load the project.
"
Class {
	#name : #PBImportProjectFromGitPresenter,
	#superclass : #SpOptionPresenter,
	#instVars : [
		'repositoryUrlInputText',
		'versionInputText',
		'iceErrorVisitor'
	],
	#category : #'Pakbot-Browser-Presenters-NewProject'
}

{ #category : #examples }
PBImportProjectFromGitPresenter class >> example [
	 self new open
]

{ #category : #layout }
PBImportProjectFromGitPresenter >> defaultLayout [
	
	^ SpGridLayout build: [ :builder |
		builder
			beColumnNotHomogeneous;
			column: 2 withConstraints: [ :c | c beExpand ];
			add: 'Package Repository Url:';
			add: repositoryUrlInputText;
			nextRow;
			add: 'Version: ';
			add: versionInputText ]
]

{ #category : #actions }
PBImportProjectFromGitPresenter >> doAccept [

	| project repository |
	
	repository := self repository ifNil: [ ^ self ].
	
	project := repository project.
	project
		registry: PBPackageRegistry default;
		repository: repository.
	"(PBLoadProjectDialog onProject: project) openDialog."
	^ project
]

{ #category : #accessing }
PBImportProjectFromGitPresenter >> iceErrorVisitor [
	^ iceErrorVisitor ifNil: [ iceErrorVisitor := IceTipInteractiveErrorVisitor new ]
]

{ #category : #initialization }
PBImportProjectFromGitPresenter >> initializePresenters [ 
	
	repositoryUrlInputText := self newTextInput 
		placeholder: 'e.g., git@github.com:pharo-pkg/project-repository';
		yourself.
	
	versionInputText := self newTextInput 
		placeholder: 'e.g., v1.0.1';
		yourself.
		
	self focusOrder 
		add: repositoryUrlInputText;
		add: versionInputText
]

{ #category : #'option list presenter' }
PBImportProjectFromGitPresenter >> optionIcon [

	^ self iconNamed: #git
]

{ #category : #'option list presenter' }
PBImportProjectFromGitPresenter >> optionTitle [

	^ 'Import from Git'
]

{ #category : #fetching }
PBImportProjectFromGitPresenter >> repository [

	| repository |
	
	[ repository := PBGitRepositoryCreator new
		url: repositoryUrlInputText text;
		version: versionInputText text;
		createAndClone ]
		on: IceCloneError, IceAuthenticationError
		do: [ :error | error acceptError: self iceErrorVisitor ].
	
	^ repository
]
