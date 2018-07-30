Class {
	#name : #CGOMetacelloConfigurationDependencyPanel,
	#superclass : #ITOptionPanel,
	#instVars : [
		'repositoryUrlLabel',
		'repositoryUrlInputText',
		'versionLabel',
		'versionInputText',
		'spacePanel',
		'groupLabel',
		'groupInputText',
		'configurationNameInputText',
		'configurationNameLabel'
	],
	#category : 'CargoPackageManager-UI'
}

{ #category : #specs }
CGOMetacelloConfigurationDependencyPanel class >> defaultSpec [
	<spec: #default>

	^ SpecLayout composed 
		newColumn: [ :col | 
			col
				newRow: [ :row | 
						row
							add: #configurationNameLabel width: self formLabelWidth;
							add: #configurationNameInputText ]
					height: self inputTextHeight;
				newRow: [ :row | 
						row
							add: #repositoryUrlLabel width: self formLabelWidth;
							add: #repositoryUrlInputText ]
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

{ #category : #building }
CGOMetacelloConfigurationDependencyPanel >> buildDependency [

	"We should have validations, probably in the domain object itself"
	self assert: self configurationNameInputText text notEmpty description: 'Invalid Configuration Name'.
	self assert: self repositoryUrlInputText text notEmpty description: 'Invalid URL'.
	self assert: self versionInputText text notEmpty description: 'Invalid version'.

	^ PBMetacelloConfigurationProjectDependency
		name: self configurationNameInputText text
		repositoryUrl: self repositoryUrlInputText text
		version: self versionInputText text
]

{ #category : #accessing }
CGOMetacelloConfigurationDependencyPanel >> configurationNameInputText [
	^ configurationNameInputText
]

{ #category : #accessing }
CGOMetacelloConfigurationDependencyPanel >> configurationNameInputText: anObject [
	configurationNameInputText := anObject
]

{ #category : #accessing }
CGOMetacelloConfigurationDependencyPanel >> configurationNameLabel [
	^ configurationNameLabel
]

{ #category : #accessing }
CGOMetacelloConfigurationDependencyPanel >> configurationNameLabel: anObject [
	configurationNameLabel := anObject
]

{ #category : #accessing }
CGOMetacelloConfigurationDependencyPanel >> groupInputText [
	^ groupInputText
]

{ #category : #accessing }
CGOMetacelloConfigurationDependencyPanel >> groupInputText: anObject [
	groupInputText := anObject
]

{ #category : #accessing }
CGOMetacelloConfigurationDependencyPanel >> groupLabel [
	^ groupLabel
]

{ #category : #accessing }
CGOMetacelloConfigurationDependencyPanel >> groupLabel: anObject [
	groupLabel := anObject
]

{ #category : #accessing }
CGOMetacelloConfigurationDependencyPanel >> icon [
	
	^ self iconNamed: PBMetacelloConfigurationProjectDependency iconName
]

{ #category : #initialization }
CGOMetacelloConfigurationDependencyPanel >> initializeSpacePanel [
	"just to gain space"
	spacePanel := self newPanel. 
]

{ #category : #initialization }
CGOMetacelloConfigurationDependencyPanel >> initializeWidgets [

	self initializeSpacePanel.

	configurationNameLabel := self newLabel label: 'Configuration of'.
	configurationNameInputText := self newTextInput 
		ghostText: 'e.g., MyProject';
		autoAccept: true.

	repositoryUrlLabel := self newLabel label: 'Repository Url'.
	repositoryUrlInputText := self newTextInput 
		ghostText: 'e.g., github://project-owner/project';
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
		add: self configurationNameInputText;
		add: self repositoryUrlInputText;
		add: self versionInputText;
		add: self groupInputText
]

{ #category : #accessing }
CGOMetacelloConfigurationDependencyPanel >> openDialogOnAccept: aBlockClosure onCancel: aBlockClosure2 [ 
	
	self openDialogWithSpec
]

{ #category : #accessing }
CGOMetacelloConfigurationDependencyPanel >> repositoryUrlInputText [
	^ repositoryUrlInputText
]

{ #category : #accessing }
CGOMetacelloConfigurationDependencyPanel >> repositoryUrlInputText: anObject [
	repositoryUrlInputText := anObject
]

{ #category : #accessing }
CGOMetacelloConfigurationDependencyPanel >> repositoryUrlLabel [
	^ repositoryUrlLabel
]

{ #category : #accessing }
CGOMetacelloConfigurationDependencyPanel >> repositoryUrlLabel: anObject [
	repositoryUrlLabel := anObject
]

{ #category : #accessing }
CGOMetacelloConfigurationDependencyPanel >> spacePanel [
	^ spacePanel
]

{ #category : #accessing }
CGOMetacelloConfigurationDependencyPanel >> spacePanel: anObject [
	spacePanel := anObject
]

{ #category : #accessing }
CGOMetacelloConfigurationDependencyPanel >> title [

	^ 'Metacello Configuration'
]

{ #category : #accessing }
CGOMetacelloConfigurationDependencyPanel >> versionInputText [
	^ versionInputText
]

{ #category : #accessing }
CGOMetacelloConfigurationDependencyPanel >> versionInputText: anObject [
	versionInputText := anObject
]

{ #category : #accessing }
CGOMetacelloConfigurationDependencyPanel >> versionLabel [
	^ versionLabel
]

{ #category : #accessing }
CGOMetacelloConfigurationDependencyPanel >> versionLabel: anObject [
	versionLabel := anObject
]
