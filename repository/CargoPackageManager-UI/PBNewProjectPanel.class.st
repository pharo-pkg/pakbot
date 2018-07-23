Class {
	#name : #PBNewProjectPanel,
	#superclass : #ITOptionPanel,
	#instVars : [
		'baselineNameLabel',
		'baselineNameInputText',
		'repositoryUrlLabel',
		'repositoryUrlInputText',
		'sourceDirectoryLabel',
		'sourceDirectoryInputText',
		'versionLabel',
		'versionInputText',
		'spacePanel',
		'groupLabel',
		'groupInputText'
	],
	#category : #'CargoPackageManager-UI-NewProject'
}

{ #category : #specs }
PBNewProjectPanel class >> defaultSpec [
	<spec: #default>

	^ SpecLayout composed 
		newColumn: [ :col | 
			col
				newRow: [ :row | 
						row
							add: #baselineNameLabel width: self formLabelWidth;
							add: #baselineNameInputText ]
					height: self inputTextHeight;
				newRow: [ :row | 
						row
							add: #repositoryUrlLabel width: self formLabelWidth;
							add: #repositoryUrlInputText ]
					height: self inputTextHeight;
				newRow: [ :row | 
						row
							add: #sourceDirectoryLabel width: self formLabelWidth;
							add: #sourceDirectoryInputText ]
					height: self inputTextHeight;
				newRow: [ :row | 
						row
							add: #versionLabel width: self formLabelWidth;
							add: #versionInputText ]
					height: self inputTextHeight;
				newRow: [ :row | 
						row
							add: #groupLabel width: self formLabelWidth;
							add: #groupInputText ]
					height: self inputTextHeight;
				newRow: #spacePanel ]
]

{ #category : #accessing }
PBNewProjectPanel >> baselineNameInputText [
	^ baselineNameInputText
]

{ #category : #accessing }
PBNewProjectPanel >> baselineNameInputText: anObject [
	baselineNameInputText := anObject
]

{ #category : #accessing }
PBNewProjectPanel >> baselineNameLabel [
	^ baselineNameLabel
]

{ #category : #accessing }
PBNewProjectPanel >> baselineNameLabel: anObject [
	baselineNameLabel := anObject
]

{ #category : #building }
PBNewProjectPanel >> buildDependency [
	
	self notYetImplemented
]

{ #category : #accessing }
PBNewProjectPanel >> groupInputText [
	^ groupInputText
]

{ #category : #accessing }
PBNewProjectPanel >> groupInputText: anObject [
	groupInputText := anObject
]

{ #category : #accessing }
PBNewProjectPanel >> groupLabel [
	^ groupLabel
]

{ #category : #accessing }
PBNewProjectPanel >> groupLabel: anObject [
	groupLabel := anObject
]

{ #category : #accessing }
PBNewProjectPanel >> icon [

	^ self iconNamed: #git
]

{ #category : #initialization }
PBNewProjectPanel >> initializeSpacePanel [
	"just to gain space"
	spacePanel := self newPanel. 
]

{ #category : #initialization }
PBNewProjectPanel >> initializeWidgets [

	self initializeSpacePanel.

	baselineNameLabel := self newLabel label: 'Baseline of'.
	baselineNameInputText := self newTextInput 
		ghostText: 'e.g., MyProject';
		autoAccept: true.

	repositoryUrlLabel := self newLabel label: 'Repository Url'.
	repositoryUrlInputText := self newTextInput 
		ghostText: 'e.g., github://project-owner/project';
		autoAccept: true.
		
	sourceDirectoryLabel := self newLabel label: 'Source directory'.
	sourceDirectoryInputText := self newTextInput 
		ghostText: 'e.g., src';
		autoAccept: true.
		
	versionLabel := self newLabel label: 'Version'.
	versionInputText := self newTextInput 
		ghostText: 'e.g., v1.0.1';
		autoAccept: true.
		
	groupLabel := self newLabel label: 'Group'.
	groupInputText := self newTextInput 
		ghostText: 'e.g., development';
		autoAccept: true.
		
	self focusOrder 
		add: self baselineNameInputText;
		add: self repositoryUrlInputText;
		add: self sourceDirectoryInputText;
		add: self versionInputText;
		add: self groupInputText
]

{ #category : #opening }
PBNewProjectPanel >> openDialogOnAccept: aBlockClosure onCancel: aBlockClosure2 [ 
	
	self openDialogWithSpec 
]

{ #category : #accessing }
PBNewProjectPanel >> repositoryUrlInputText [
	^ repositoryUrlInputText
]

{ #category : #accessing }
PBNewProjectPanel >> repositoryUrlInputText: anObject [
	repositoryUrlInputText := anObject
]

{ #category : #accessing }
PBNewProjectPanel >> repositoryUrlLabel [
	^ repositoryUrlLabel
]

{ #category : #accessing }
PBNewProjectPanel >> repositoryUrlLabel: anObject [
	repositoryUrlLabel := anObject
]

{ #category : #accessing }
PBNewProjectPanel >> sourceDirectoryInputText [
	^ sourceDirectoryInputText
]

{ #category : #accessing }
PBNewProjectPanel >> sourceDirectoryInputText: anObject [
	sourceDirectoryInputText := anObject
]

{ #category : #accessing }
PBNewProjectPanel >> sourceDirectoryLabel [
	^ sourceDirectoryLabel
]

{ #category : #accessing }
PBNewProjectPanel >> sourceDirectoryLabel: anObject [
	sourceDirectoryLabel := anObject
]

{ #category : #accessing }
PBNewProjectPanel >> spacePanel [
	^ spacePanel
]

{ #category : #accessing }
PBNewProjectPanel >> spacePanel: anObject [
	spacePanel := anObject
]

{ #category : #accessing }
PBNewProjectPanel >> title [

	^ 'New Project'
]

{ #category : #accessing }
PBNewProjectPanel >> versionInputText [
	^ versionInputText
]

{ #category : #accessing }
PBNewProjectPanel >> versionInputText: anObject [
	versionInputText := anObject
]

{ #category : #accessing }
PBNewProjectPanel >> versionLabel [
	^ versionLabel
]

{ #category : #accessing }
PBNewProjectPanel >> versionLabel: anObject [
	versionLabel := anObject
]
