Class {
	#name : #PBImportProjectFromGitPanel,
	#superclass : #ITOptionPanel,
	#instVars : [
		'repositoryUrlLabel',
		'repositoryUrlInputText',
		'versionLabel',
		'versionInputText',
		'spacePanel',
		'iceErrorVisitor'
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
							add: #repositoryUrlLabel width: self formLabelWidth;
							add: #repositoryUrlInputText ]
					height: self inputTextHeight;
				newRow: [ :row | 
						row
							add: #versionLabel width: self formLabelWidth;
							add: #versionInputText ]
					height: self inputTextHeight;
				newRow: #spacePanel ]
]

{ #category : #accessing }
PBImportProjectFromGitPanel >> accept [
	| project repository |
	[ repository := PBGitRepositoryCreator new
		url: repositoryUrlInputText text;
		version: versionInputText text;
		createAndClone ]
		on: IceCloneError, IceAuthenticationError
		do: [ :error | 
			error acceptError: self iceErrorVisitor.
			^ nil ].
	project := repository project.
	project
		registry: PBPackageRegistry default;
		repository: repository.
	(PBLoadProjectDialog onProject: project) openDialogWithSpec.
	^ project
]

{ #category : #accessing }
PBImportProjectFromGitPanel >> iceErrorVisitor [
	^ iceErrorVisitor ifNil: [ iceErrorVisitor := IceTipInteractiveErrorVisitor new ]
]

{ #category : #accessing }
PBImportProjectFromGitPanel >> iceErrorVisitor: aVisitor [
	iceErrorVisitor := aVisitor 
]

{ #category : #accessing }
PBImportProjectFromGitPanel >> icon [

	^ self iconNamed: #git
]

{ #category : #initialization }
PBImportProjectFromGitPanel >> initializeSpacePanel [
	"just to gain space"
	spacePanel := self newPanel. 
]

{ #category : #initialization }
PBImportProjectFromGitPanel >> initializeWidgets [

	self initializeSpacePanel.

	repositoryUrlLabel := self newLabel label: 'Repository Url'.
	repositoryUrlInputText := self newTextInput 
		ghostText: 'e.g., git@github.com:project-owner/project';
		autoAccept: true.
		
	versionLabel := self newLabel label: 'Version'.
	versionInputText := self newTextInput 
		ghostText: 'e.g., v1.0.1';
		autoAccept: true.
		
	self focusOrder 
		add: self repositoryUrlInputText;
		add: self versionInputText
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
