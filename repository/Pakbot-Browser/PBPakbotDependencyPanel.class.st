Class {
	#name : #PBPakbotDependencyPanel,
	#superclass : #PBAbstractDependencyPresenter,
	#instVars : [
		'projectName',
		'projectVersion',
		'projectRepository'
	],
	#category : #'Pakbot-Browser-Presenters-Dependencies'
}

{ #category : #examples }
PBPakbotDependencyPanel class >> example [
	(self on: nil) openWithSpec
]

{ #category : #building }
PBPakbotDependencyPanel >> buildDependency [
	^ PBPakbotProjectDependency
		named: projectName text
		repositoryUrl: projectRepository text
		version: projectVersion text
]

{ #category : #specs }
PBPakbotDependencyPanel >> defaultLayout [ 
	^ SpGridLayout new
		add: 'Name' at: 1@1;
		add: projectName at: 2@1;
		add: 'Version' at: 1@2;
		add: projectVersion at: 2@2;
		add: 'Repository' at: 1@3;
		add: projectRepository at: 2@3;
		yourself
		
]

{ #category : #accessing }
PBPakbotDependencyPanel >> icon [
	^ self iconNamed: #glamorousBookmark
]

{ #category : #initialization }
PBPakbotDependencyPanel >> initializeForm [
	projectName := (self instantiate: SpInputTextFieldWithStatusPresenter)
			placeholder: 'e.g., My Project';
			yourself.
			"with: [ :field | field beRequired ];"

	projectVersion := (self instantiate: SpInputTextFieldWithStatusPresenter)
			placeholder: 'e.g., 1.0.1';
			yourself.
			"with: [ :field | field beRequired ];"

	projectRepository := (self instantiate: SpInputTextFieldWithStatusPresenter)
		placeholder: 'e.g., github://project-owner/project';
		yourself.
		"validateOnChange;
		whenChangedDo: [ self valueChanged ]."

]

{ #category : #initialization }
PBPakbotDependencyPanel >> setInitialValues [

	projectName text: self dependency name.
	projectRepository text: self dependency repositoryUrl.
	projectVersion text: self dependency	version asString

]

{ #category : #accessing }
PBPakbotDependencyPanel >> title [
	^ 'Pakbot Project'
]

{ #category : #building }
PBPakbotDependencyPanel >> updateDependency [

	self dependency
		name: projectName text;
		repositoryUrl: projectRepository text;
		version: projectVersion text
]
