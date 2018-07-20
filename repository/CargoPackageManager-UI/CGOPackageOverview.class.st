"
I'm in charge of displaying core meta-information on packages.
I also allow to edit these meta-data.

I mainly interacte with OnGoingPackage[Unit/Assembly]

"
Class {
	#name : #CGOPackageOverview,
	#superclass : #CGOPackageView,
	#instVars : [
		'ongoingPackageVersion',
		'nameLabel',
		'nameInputField',
		'versionLabel',
		'versionInputField',
		'repositoryLabel',
		'repositoryInputField',
		'descriptionLabel',
		'descriptionText'
	],
	#category : 'CargoPackageManager-UI'
}

{ #category : #specs }
CGOPackageOverview class >> defaultSpec [
	^ SpecLayout composed
		newColumn: [ : column | 
			column
				newRow: [ :nameRow |
					nameRow 
						add: #nameLabel width: self labelSize;
						add: #nameInputField ]
				height: self inputTextHeight;
				newRow: [ :versionRow |
					versionRow 
						add: #versionLabel width: self labelSize;
						add: #versionInputField ]
				height: self inputTextHeight;
				newRow: [ :repositoryRow |
					repositoryRow 
						add: #repositoryLabel width: self labelSize;
						add: #repositoryInputField ]
				height: self inputTextHeight;
				add: #descriptionLabel height: self inputTextHeight;
			 	add: #descriptionText ]
]

{ #category : #example }
CGOPackageOverview class >> example [
	^ self openOn: (CGOOngoingPackage example)
]

{ #category : #example }
CGOPackageOverview class >> example2 [
	^ self openWithMinimalSpecOn: (CGOOngoingPackage example)
]

{ #category : #specs }
CGOPackageOverview class >> minimalSpec [
	^ SpecLayout composed
		newColumn: [ : column | 
			column
				newRow: [ :nameRow |
					nameRow 
						add: #nameLabel width: self labelSize;
						add: #nameInputField ]
				height: self inputTextHeight;
				add: #descriptionLabel height: self inputTextHeight;
			 	add: #descriptionText ]
]

{ #category : #'instance creation' }
CGOPackageOverview class >> newOn: anOngoingPackageVersion owner: owner [
	^ self basicNew
		initializeWith: anOngoingPackageVersion;
		yourself
]

{ #category : #opening }
CGOPackageOverview class >> openOn: anOngoingPackageVersion [
	(self newOn: anOngoingPackageVersion owner: nil)
		openWithSpec
]

{ #category : #opening }
CGOPackageOverview class >> openWithMinimalSpecOn: anOngoingPackageVersion [
	(self newOn: anOngoingPackageVersion owner: nil)
		openWithSpec: #minimalSpec
]

{ #category : #accessing }
CGOPackageOverview >> descriptionLabel [
	^ descriptionLabel
]

{ #category : #accessing }
CGOPackageOverview >> descriptionText [
	^ descriptionText
]

{ #category : #initialization }
CGOPackageOverview >> initialExtent [
	 ^ (900.0@350.0)
]

{ #category : #initialization }
CGOPackageOverview >> initializePresenter [
	nameInputField acceptBlock: [ self error: 'Project name should not change' ].
	versionInputField acceptBlock: [ self updateVersion ].
	repositoryInputField acceptBlock: [ self updateRepository ].
	descriptionText whenTextIsAccepted: 
		[ :newText | self updateDescription ]
]

{ #category : #initialization }
CGOPackageOverview >> initializeWidgets [
	(nameLabel := self newLabel)
		label: 'Name:'.
	self newTextInputField: #nameInputField.
		
	(versionLabel := self newLabel)
		label: 'Version:'.
	self newTextInputField: #versionInputField. 

	"repository"
	(repositoryLabel := self newLabel)
		label: 'Repository:'.
	self newTextInputField: #repositoryInputField. 
		
	(descriptionLabel := self newLabel)
		label: 'Description:'.
	descriptionText := self newText
]

{ #category : #initialization }
CGOPackageOverview >> initializeWith: anOngoingPackageUnit [
	super initialize.
	ongoingPackageVersion := anOngoingPackageUnit.
	self refreshWidgetValues
]

{ #category : #accessing }
CGOPackageOverview >> nameInputField [
	^ nameInputField
]

{ #category : #accessing }
CGOPackageOverview >> nameLabel [
	^ nameLabel
]

{ #category : #initialization }
CGOPackageOverview >> refreshWidgetValues [
	nameInputField text: ongoingPackageVersion packageName.
	versionInputField text: ongoingPackageVersion version asString.
	ongoingPackageVersion isProject
		ifTrue: [ ongoingPackageVersion repository ifNotNil: 
			[ :repository | repositoryInputField text: repository repositoryUrl ] ].
	descriptionText text: ongoingPackageVersion description
]

{ #category : #accessing }
CGOPackageOverview >> repositoryInputField [
	^ repositoryInputField
]

{ #category : #accessing }
CGOPackageOverview >> repositoryLabel [
	^ repositoryLabel
]

{ #category : #updating }
CGOPackageOverview >> updateDescription [
	ongoingPackageVersion description: descriptionText text asString
]

{ #category : #updating }
CGOPackageOverview >> updateDescriptionWith: aString [
	ongoingPackageVersion description: aString printString
]

{ #category : #updating }
CGOPackageOverview >> updateName [
	ongoingPackageVersion name: nameInputField text asSymbol printString
]

{ #category : #updating }
CGOPackageOverview >> updateRepository [
	| repositoryString repository subdirectory |
	repositoryString := repositoryInputField text.
	(CGOSourceRepository isGitRepositoryUrl: repositoryString)
		ifTrue: [ subdirectory := UIManager default 
		request: 'Subdirectory for git repository (leave it empty if none)' 
		initialAnswer: ''. ].
	repository := CGOSourceRepository 
		fromStringUrl: repositoryString 
		subdirectory:  subdirectory.
	ongoingPackageVersion repository: repository.
]

{ #category : #updating }
CGOPackageOverview >> updateVersion [
	| versionString |
	versionString := versionInputField text.
	versionString asSemanticVersion. "check the version string"
	ongoingPackageVersion version: versionString
]

{ #category : #accessing }
CGOPackageOverview >> versionInputField [
	^ versionInputField
]

{ #category : #accessing }
CGOPackageOverview >> versionLabel [
	^ versionLabel
]
