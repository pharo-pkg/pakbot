Class {
	#name : #PBMetacelloConfigurationDependencyPanel,
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
	#category : #'CargoPackageManager-UI-NewDependency'
}

{ #category : #specs }
PBMetacelloConfigurationDependencyPanel class >> defaultSpec [
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
PBMetacelloConfigurationDependencyPanel >> buildDependency [

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
PBMetacelloConfigurationDependencyPanel >> configurationNameInputText [
	^ configurationNameInputText
]

{ #category : #accessing }
PBMetacelloConfigurationDependencyPanel >> configurationNameInputText: anObject [
	configurationNameInputText := anObject
]

{ #category : #accessing }
PBMetacelloConfigurationDependencyPanel >> configurationNameLabel [
	^ configurationNameLabel
]

{ #category : #accessing }
PBMetacelloConfigurationDependencyPanel >> configurationNameLabel: anObject [
	configurationNameLabel := anObject
]

{ #category : #accessing }
PBMetacelloConfigurationDependencyPanel >> groupInputText [
	^ groupInputText
]

{ #category : #accessing }
PBMetacelloConfigurationDependencyPanel >> groupInputText: anObject [
	groupInputText := anObject
]

{ #category : #accessing }
PBMetacelloConfigurationDependencyPanel >> groupLabel [
	^ groupLabel
]

{ #category : #accessing }
PBMetacelloConfigurationDependencyPanel >> groupLabel: anObject [
	groupLabel := anObject
]

{ #category : #accessing }
PBMetacelloConfigurationDependencyPanel >> icon [
	
	^ self iconNamed: PBMetacelloConfigurationProjectDependency iconName
]

{ #category : #initialization }
PBMetacelloConfigurationDependencyPanel >> initializeSpacePanel [
	"just to gain space"
	spacePanel := self newPanel. 
]

{ #category : #initialization }
PBMetacelloConfigurationDependencyPanel >> initializeWidgets [

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

{ #category : #validation }
PBMetacelloConfigurationDependencyPanel >> isValid [
	^ true
]

{ #category : #accessing }
PBMetacelloConfigurationDependencyPanel >> openDialogOnAccept: aBlockClosure onCancel: aBlockClosure2 [ 
	
	self openDialogWithSpec
]

{ #category : #accessing }
PBMetacelloConfigurationDependencyPanel >> repositoryUrlInputText [
	^ repositoryUrlInputText
]

{ #category : #accessing }
PBMetacelloConfigurationDependencyPanel >> repositoryUrlInputText: anObject [
	repositoryUrlInputText := anObject
]

{ #category : #accessing }
PBMetacelloConfigurationDependencyPanel >> repositoryUrlLabel [
	^ repositoryUrlLabel
]

{ #category : #accessing }
PBMetacelloConfigurationDependencyPanel >> repositoryUrlLabel: anObject [
	repositoryUrlLabel := anObject
]

{ #category : #accessing }
PBMetacelloConfigurationDependencyPanel >> spacePanel [
	^ spacePanel
]

{ #category : #accessing }
PBMetacelloConfigurationDependencyPanel >> spacePanel: anObject [
	spacePanel := anObject
]

{ #category : #accessing }
PBMetacelloConfigurationDependencyPanel >> title [

	^ 'Metacello Configuration'
]

{ #category : #accessing }
PBMetacelloConfigurationDependencyPanel >> versionInputText [
	^ versionInputText
]

{ #category : #accessing }
PBMetacelloConfigurationDependencyPanel >> versionInputText: anObject [
	versionInputText := anObject
]

{ #category : #accessing }
PBMetacelloConfigurationDependencyPanel >> versionLabel [
	^ versionLabel
]

{ #category : #accessing }
PBMetacelloConfigurationDependencyPanel >> versionLabel: anObject [
	versionLabel := anObject
]
