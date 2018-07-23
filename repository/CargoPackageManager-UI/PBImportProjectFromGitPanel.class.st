Class {
	#name : #PBImportProjectFromGitPanel,
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
PBImportProjectFromGitPanel class >> defaultSpec [
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
PBImportProjectFromGitPanel >> baselineNameInputText [
	^ baselineNameInputText
]

{ #category : #accessing }
PBImportProjectFromGitPanel >> baselineNameInputText: anObject [
	baselineNameInputText := anObject
]

{ #category : #accessing }
PBImportProjectFromGitPanel >> baselineNameLabel [
	^ baselineNameLabel
]

{ #category : #accessing }
PBImportProjectFromGitPanel >> baselineNameLabel: anObject [
	baselineNameLabel := anObject
]

{ #category : #building }
PBImportProjectFromGitPanel >> buildDependency [
	
	self notYetImplemented
]

{ #category : #accessing }
PBImportProjectFromGitPanel >> groupInputText [
	^ groupInputText
]

{ #category : #accessing }
PBImportProjectFromGitPanel >> groupInputText: anObject [
	groupInputText := anObject
]

{ #category : #accessing }
PBImportProjectFromGitPanel >> groupLabel [
	^ groupLabel
]

{ #category : #accessing }
PBImportProjectFromGitPanel >> groupLabel: anObject [
	groupLabel := anObject
]

{ #category : #accessing }
PBImportProjectFromGitPanel >> icon [

	^ self iconNamed: #dirtyPackage
]

{ #category : #initialization }
PBImportProjectFromGitPanel >> initializeSpacePanel [
	"just to gain space"
	spacePanel := self newPanel. 
]

{ #category : #initialization }
PBImportProjectFromGitPanel >> initializeWidgets [

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
PBImportProjectFromGitPanel >> openDialogOnAccept: aBlockClosure onCancel: aBlockClosure2 [ 
	
	self openDialogWithSpec 
]

{ #category : #accessing }
PBImportProjectFromGitPanel >> repositoryUrlInputText [
	^ repositoryUrlInputText
]

{ #category : #accessing }
PBImportProjectFromGitPanel >> repositoryUrlInputText: anObject [
	repositoryUrlInputText := anObject
]

{ #category : #accessing }
PBImportProjectFromGitPanel >> repositoryUrlLabel [
	^ repositoryUrlLabel
]

{ #category : #accessing }
PBImportProjectFromGitPanel >> repositoryUrlLabel: anObject [
	repositoryUrlLabel := anObject
]

{ #category : #accessing }
PBImportProjectFromGitPanel >> sourceDirectoryInputText [
	^ sourceDirectoryInputText
]

{ #category : #accessing }
PBImportProjectFromGitPanel >> sourceDirectoryInputText: anObject [
	sourceDirectoryInputText := anObject
]

{ #category : #accessing }
PBImportProjectFromGitPanel >> sourceDirectoryLabel [
	^ sourceDirectoryLabel
]

{ #category : #accessing }
PBImportProjectFromGitPanel >> sourceDirectoryLabel: anObject [
	sourceDirectoryLabel := anObject
]

{ #category : #accessing }
PBImportProjectFromGitPanel >> spacePanel [
	^ spacePanel
]

{ #category : #accessing }
PBImportProjectFromGitPanel >> spacePanel: anObject [
	spacePanel := anObject
]

{ #category : #accessing }
PBImportProjectFromGitPanel >> title [

	^ 'Import from Git'
]

{ #category : #accessing }
PBImportProjectFromGitPanel >> versionInputText [
	^ versionInputText
]

{ #category : #accessing }
PBImportProjectFromGitPanel >> versionInputText: anObject [
	versionInputText := anObject
]

{ #category : #accessing }
PBImportProjectFromGitPanel >> versionLabel [
	^ versionLabel
]

{ #category : #accessing }
PBImportProjectFromGitPanel >> versionLabel: anObject [
	versionLabel := anObject
]
