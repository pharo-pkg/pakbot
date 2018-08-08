Class {
	#name : #PBMetacelloBaselineDependencyPanel,
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
	#category : #'CargoPackageManager-UI-NewDependency'
}

{ #category : #specs }
PBMetacelloBaselineDependencyPanel class >> defaultSpec [
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
PBMetacelloBaselineDependencyPanel >> baselineNameInputText [
	^ baselineNameInputText
]

{ #category : #accessing }
PBMetacelloBaselineDependencyPanel >> baselineNameInputText: anObject [
	baselineNameInputText := anObject
]

{ #category : #accessing }
PBMetacelloBaselineDependencyPanel >> baselineNameLabel [
	^ baselineNameLabel
]

{ #category : #accessing }
PBMetacelloBaselineDependencyPanel >> baselineNameLabel: anObject [
	baselineNameLabel := anObject
]

{ #category : #building }
PBMetacelloBaselineDependencyPanel >> buildDependency [

	"We should have validations, probably in the domain object itself"
	self assert: self baselineNameInputText text notEmpty description: 'Invalid Baseline Name'.
	self assert: self repositoryUrlInputText text notEmpty description: 'Invalid URL'.
	self assert: self versionInputText text notEmpty description: 'Invalid version'.

	^ PBMetacelloBaselineProjectDependency
		name: self baselineNameInputText text
		repositoryUrl: self repositoryUrlInputText text
		version: self versionInputText text
]

{ #category : #accessing }
PBMetacelloBaselineDependencyPanel >> groupInputText [
	^ groupInputText
]

{ #category : #accessing }
PBMetacelloBaselineDependencyPanel >> groupInputText: anObject [
	groupInputText := anObject
]

{ #category : #accessing }
PBMetacelloBaselineDependencyPanel >> groupLabel [
	^ groupLabel
]

{ #category : #accessing }
PBMetacelloBaselineDependencyPanel >> groupLabel: anObject [
	groupLabel := anObject
]

{ #category : #accessing }
PBMetacelloBaselineDependencyPanel >> icon [

	^ self iconNamed: PBMetacelloBaselineProjectDependency iconName
]

{ #category : #initialization }
PBMetacelloBaselineDependencyPanel >> initializeSpacePanel [
	"just to gain space"
	spacePanel := self newPanel. 
]

{ #category : #initialization }
PBMetacelloBaselineDependencyPanel >> initializeWidgets [

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

{ #category : #validation }
PBMetacelloBaselineDependencyPanel >> isValid [
	^ true
]

{ #category : #opening }
PBMetacelloBaselineDependencyPanel >> openDialogOnAccept: aBlockClosure onCancel: aBlockClosure2 [ 
	
	self openDialogWithSpec 
]

{ #category : #accessing }
PBMetacelloBaselineDependencyPanel >> repositoryUrlInputText [
	^ repositoryUrlInputText
]

{ #category : #accessing }
PBMetacelloBaselineDependencyPanel >> repositoryUrlInputText: anObject [
	repositoryUrlInputText := anObject
]

{ #category : #accessing }
PBMetacelloBaselineDependencyPanel >> repositoryUrlLabel [
	^ repositoryUrlLabel
]

{ #category : #accessing }
PBMetacelloBaselineDependencyPanel >> repositoryUrlLabel: anObject [
	repositoryUrlLabel := anObject
]

{ #category : #accessing }
PBMetacelloBaselineDependencyPanel >> sourceDirectoryInputText [
	^ sourceDirectoryInputText
]

{ #category : #accessing }
PBMetacelloBaselineDependencyPanel >> sourceDirectoryInputText: anObject [
	sourceDirectoryInputText := anObject
]

{ #category : #accessing }
PBMetacelloBaselineDependencyPanel >> sourceDirectoryLabel [
	^ sourceDirectoryLabel
]

{ #category : #accessing }
PBMetacelloBaselineDependencyPanel >> sourceDirectoryLabel: anObject [
	sourceDirectoryLabel := anObject
]

{ #category : #accessing }
PBMetacelloBaselineDependencyPanel >> spacePanel [
	^ spacePanel
]

{ #category : #accessing }
PBMetacelloBaselineDependencyPanel >> spacePanel: anObject [
	spacePanel := anObject
]

{ #category : #accessing }
PBMetacelloBaselineDependencyPanel >> title [

	^ 'Metacello Baseline'
]

{ #category : #accessing }
PBMetacelloBaselineDependencyPanel >> versionInputText [
	^ versionInputText
]

{ #category : #accessing }
PBMetacelloBaselineDependencyPanel >> versionInputText: anObject [
	versionInputText := anObject
]

{ #category : #accessing }
PBMetacelloBaselineDependencyPanel >> versionLabel [
	^ versionLabel
]

{ #category : #accessing }
PBMetacelloBaselineDependencyPanel >> versionLabel: anObject [
	versionLabel := anObject
]
