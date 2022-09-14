"
Presenter to edit Metacello Baseline project dependency.
"
Class {
	#name : #PBMetacelloBaselineDependencyPresenter,
	#superclass : #PBAbstractDependencyPresenter,
	#instVars : [
		'nameInput',
		'repositoryUrlInput',
		'versionInput',
		'srcDirectoryInput',
		'groupInput'
	],
	#category : #'Pakbot-Browser-Presenters-Dependencies'
}

{ #category : #examples }
PBMetacelloBaselineDependencyPresenter class >> example [
	
	| dependency |
	dependency := PBMetacelloBaselineProjectDependency example.
	(self on: dependency) 
		openDialogOnAccept: [ dependency inspect ] 
		onCancel: [ ].
]

{ #category : #layout }
PBMetacelloBaselineDependencyPresenter >> defaultLayout [
	
	^ SpGridLayout build: [ :builder |
		builder
			beColumnNotHomogeneous;
			column: 2 withConstraints: [ :c | c beExpand ];
			add: 'Baseline of'; add: nameInput; nextRow;
			add: 'Repository'; add: repositoryUrlInput; nextRow;
			add: 'Version'; add: versionInput; nextRow;
			add: 'Source directory'; add: srcDirectoryInput; nextRow;
			add:  'Group'; add: groupInput ]
]

{ #category : #accessing }
PBMetacelloBaselineDependencyPresenter >> icon [

	^ self iconNamed: PBMetacelloBaselineProjectDependency iconName
]

{ #category : #initialization }
PBMetacelloBaselineDependencyPresenter >> initializePresenters [ 

	nameInput := self newTextInput
		placeholder: 'e.g., My Project';
		yourself.
		
	repositoryUrlInput := self newTextInput
		placeholder: 'e.g., github://project-owner/project';
		yourself.
		
	versionInput := self newTextInput
		placeholder: 'e.g., 1.0.1';
		yourself.
		
	srcDirectoryInput := self newTextInput
		placeholder: 'e.g., src';
		yourself.
		
	groupInput := self newTextInput
		placeholder: 'e.g., development';
		yourself.
	
	
	
]

{ #category : #initialization }
PBMetacelloBaselineDependencyPresenter >> setInitialValues [

	nameInput text: self dependency name.
	repositoryUrlInput text: self dependency repositoryUrl.
	versionInput text: self dependency version asString

]

{ #category : #accessing }
PBMetacelloBaselineDependencyPresenter >> title [

	^ 'Metacello Baseline'
]

{ #category : #building }
PBMetacelloBaselineDependencyPresenter >> updateDependency [
	
	self dependency
		setName: nameInput text
		repositoryUrl: repositoryUrlInput text
		version: versionInput text
]
