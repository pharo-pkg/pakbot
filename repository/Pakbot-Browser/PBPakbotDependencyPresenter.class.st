"
Presenter to edit a Pakbot project dependency.
"
Class {
	#name : #PBPakbotDependencyPresenter,
	#superclass : #PBAbstractDependencyPresenter,
	#instVars : [
		'projectName',
		'projectVersion',
		'projectRepository'
	],
	#category : #'Pakbot-Browser-Presenters-Dependencies'
}

{ #category : #examples }
PBPakbotDependencyPresenter class >> example [

	(self on: PBPakbotProjectDependency example) open
]

{ #category : #building }
PBPakbotDependencyPresenter >> buildDependency [
	^ PBPakbotProjectDependency
		named: projectName text
		repositoryUrl: projectRepository text
		version: projectVersion text
]

{ #category : #layout }
PBPakbotDependencyPresenter >> defaultLayout [ 

	^ SpGridLayout build: [ :builder |
		builder
			beColumnNotHomogeneous;
			column: 2 withConstraints: [ :c | c beExpand ];
			add: 'Name'; add: projectName; nextRow;
			add: 'Version' ; add: projectVersion; nextRow;
			add: 'Repository'; add: projectRepository ]
]

{ #category : #accessing }
PBPakbotDependencyPresenter >> icon [
	^ self iconNamed: #glamorousBookmark
]

{ #category : #initialization }
PBPakbotDependencyPresenter >> initializePresenters [
	projectName := (self instantiate: SpTextInputFieldWithValidationPresenter)
			placeholder: 'e.g., My Project';
			whenTextChangedDo: [ self updateOkButton ];
			beRequired;
			yourself.

	projectVersion := (self instantiate: SpTextInputFieldWithValidationPresenter)
			placeholder: 'e.g., 1.0.1';
			whenTextChangedDo: [ self updateOkButton ];
			beRequired;
			yourself.
			
	projectRepository := (self instantiate: SpTextInputFieldWithValidationPresenter)
		placeholder: 'e.g., github://project-owner/project';
		yourself.
		"validateOnChange;
		whenChangedDo: [ self valueChanged ]."
	
	super initializePresenters.
]

{ #category : #accessing }
PBPakbotDependencyPresenter >> name: aName [
	
	projectName text: aName.
]

{ #category : #accessing }
PBPakbotDependencyPresenter >> repositoryUrl: aString [ 
	
	projectRepository text: aString.
]

{ #category : #initialization }
PBPakbotDependencyPresenter >> setInitialValues [

	projectName text: self dependency name.
	projectRepository text: self dependency repositoryUrl.
	projectVersion text: self dependency	version asString

]

{ #category : #accessing }
PBPakbotDependencyPresenter >> title [
	^ 'Pakbot Project'
]

{ #category : #building }
PBPakbotDependencyPresenter >> updateDependency [

	self dependency ifNil: [ dependency := self buildDependency. ^ self ].
	
	self dependency
		name: projectName text;
		repositoryUrl: projectRepository text;
		version: projectVersion text
]

{ #category : #accessing }
PBPakbotDependencyPresenter >> version: aString [ 
	
	projectVersion text: aString.
]
