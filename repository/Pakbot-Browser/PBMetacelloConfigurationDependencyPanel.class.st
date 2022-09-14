"
Presenter to edit a Metacello Configuration dependency.
"
Class {
	#name : #PBMetacelloConfigurationDependencyPanel,
	#superclass : #PBAbstractDependencyPresenter,
	#instVars : [
		'name',
		'repositoryUrl',
		'version',
		'group'
	],
	#category : #'Pakbot-Browser-Presenters-Dependencies'
}

{ #category : #examples }
PBMetacelloConfigurationDependencyPanel class >> example [

	(self on: PBMetacelloConfigurationProjectDependency example) open
]

{ #category : #building }
PBMetacelloConfigurationDependencyPanel >> buildDependency [

	^ PBMetacelloConfigurationProjectDependency
		name: name text
		repositoryUrl: repositoryUrl text
		version: version text
]

{ #category : #layout }
PBMetacelloConfigurationDependencyPanel >> defaultLayout [ 

	^ SpGridLayout build: [ :builder |
		builder
			beColumnNotHomogeneous;
			column: 2 withConstraints: [ :c | c beExpand ];
			add: 'Name'; add: name; nextRow;
			add: 'Repository'; add: repositoryUrl; nextRow;
			add: 'Version' ; add: version; nextRow;
			add: 'Group' ; add: group ]
]

{ #category : #accessing }
PBMetacelloConfigurationDependencyPanel >> icon [
	
	^ self iconNamed: PBMetacelloConfigurationProjectDependency iconName
]

{ #category : #initialization }
PBMetacelloConfigurationDependencyPanel >> initializePresenters [

	name := (self instantiate: SpTextInputFieldWithValidationPresenter)
			placeholder: 'e.g., My Project';
			yourself.
			"with: [ :field | field beRequired ];"

	repositoryUrl := (self instantiate: SpTextInputFieldWithValidationPresenter)
			placeholder: 'e.g., github://project-owner/project';
			yourself.

	version := (self instantiate: SpTextInputFieldWithValidationPresenter)
			placeholder: 'e.g., 1.0.1';
			yourself.
		"	with: [ :field | field beRequired ];"

	group := (self instantiate: SpTextInputFieldWithValidationPresenter)
			placeholder: 'e.g., development';
			yourself.
			
	"	validateOnChange;
		whenChangedDo: [ self valueChanged ]."
		
]

{ #category : #initialization }
PBMetacelloConfigurationDependencyPanel >> setInitialValues [

	name text: self dependency name.
	repositoryUrl text: self dependency repositoryUrl.
	version text: self dependency	version asString

]

{ #category : #accessing }
PBMetacelloConfigurationDependencyPanel >> title [

	^ 'Metacello Configuration'
]

{ #category : #building }
PBMetacelloConfigurationDependencyPanel >> updateDependency [

	self dependency
		name: name text;
		repositoryUrl: repositoryUrl text;
		version: version text
		
]
