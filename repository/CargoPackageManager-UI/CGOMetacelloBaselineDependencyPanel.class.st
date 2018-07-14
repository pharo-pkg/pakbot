Class {
	#name : #CGOMetacelloBaselineDependencyPanel,
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
	#category : 'CargoPackageManager-UI'
}

{ #category : #specs }
CGOMetacelloBaselineDependencyPanel class >> defaultSpec [
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
CGOMetacelloBaselineDependencyPanel >> baselineNameInputText [
	^ baselineNameInputText
]

{ #category : #accessing }
CGOMetacelloBaselineDependencyPanel >> baselineNameInputText: anObject [
	baselineNameInputText := anObject
]

{ #category : #accessing }
CGOMetacelloBaselineDependencyPanel >> baselineNameLabel [
	^ baselineNameLabel
]

{ #category : #accessing }
CGOMetacelloBaselineDependencyPanel >> baselineNameLabel: anObject [
	baselineNameLabel := anObject
]

{ #category : #building }
CGOMetacelloBaselineDependencyPanel >> buildDependency [
	
	self notYetImplemented
]

{ #category : #accessing }
CGOMetacelloBaselineDependencyPanel >> groupInputText [
	^ groupInputText
]

{ #category : #accessing }
CGOMetacelloBaselineDependencyPanel >> groupInputText: anObject [
	groupInputText := anObject
]

{ #category : #accessing }
CGOMetacelloBaselineDependencyPanel >> groupLabel [
	^ groupLabel
]

{ #category : #accessing }
CGOMetacelloBaselineDependencyPanel >> groupLabel: anObject [
	groupLabel := anObject
]

{ #category : #accessing }
CGOMetacelloBaselineDependencyPanel >> icon [

	^ self iconNamed: #komitterSmalltalkhubRemote
]

{ #category : #initialization }
CGOMetacelloBaselineDependencyPanel >> initializeSpacePanel [
	"just to gain space"
	spacePanel := self newPanel. 
]

{ #category : #initialization }
CGOMetacelloBaselineDependencyPanel >> initializeWidgets [

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
CGOMetacelloBaselineDependencyPanel >> openDialogOnAccept: aBlockClosure onCancel: aBlockClosure2 [ 
	
	self openDialogWithSpec 
]

{ #category : #accessing }
CGOMetacelloBaselineDependencyPanel >> repositoryUrlInputText [
	^ repositoryUrlInputText
]

{ #category : #accessing }
CGOMetacelloBaselineDependencyPanel >> repositoryUrlInputText: anObject [
	repositoryUrlInputText := anObject
]

{ #category : #accessing }
CGOMetacelloBaselineDependencyPanel >> repositoryUrlLabel [
	^ repositoryUrlLabel
]

{ #category : #accessing }
CGOMetacelloBaselineDependencyPanel >> repositoryUrlLabel: anObject [
	repositoryUrlLabel := anObject
]

{ #category : #accessing }
CGOMetacelloBaselineDependencyPanel >> sourceDirectoryInputText [
	^ sourceDirectoryInputText
]

{ #category : #accessing }
CGOMetacelloBaselineDependencyPanel >> sourceDirectoryInputText: anObject [
	sourceDirectoryInputText := anObject
]

{ #category : #accessing }
CGOMetacelloBaselineDependencyPanel >> sourceDirectoryLabel [
	^ sourceDirectoryLabel
]

{ #category : #accessing }
CGOMetacelloBaselineDependencyPanel >> sourceDirectoryLabel: anObject [
	sourceDirectoryLabel := anObject
]

{ #category : #accessing }
CGOMetacelloBaselineDependencyPanel >> spacePanel [
	^ spacePanel
]

{ #category : #accessing }
CGOMetacelloBaselineDependencyPanel >> spacePanel: anObject [
	spacePanel := anObject
]

{ #category : #accessing }
CGOMetacelloBaselineDependencyPanel >> title [

	^ 'Metacello Baseline'
]

{ #category : #accessing }
CGOMetacelloBaselineDependencyPanel >> versionInputText [
	^ versionInputText
]

{ #category : #accessing }
CGOMetacelloBaselineDependencyPanel >> versionInputText: anObject [
	versionInputText := anObject
]

{ #category : #accessing }
CGOMetacelloBaselineDependencyPanel >> versionLabel [
	^ versionLabel
]

{ #category : #accessing }
CGOMetacelloBaselineDependencyPanel >> versionLabel: anObject [
	versionLabel := anObject
]
