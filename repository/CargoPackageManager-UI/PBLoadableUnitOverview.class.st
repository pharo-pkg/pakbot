"
I'm in charge of displaying core meta-information on packages.
I also allow to edit these meta-data.

I mainly interacte with OnGoingPackage[Unit/Assembly]

"
Class {
	#name : #PBLoadableUnitOverview,
	#superclass : #PBLoadableUnitPanel,
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
	#category : #'CargoPackageManager-UI'
}

{ #category : #specs }
PBLoadableUnitOverview class >> defaultSpec [
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
PBLoadableUnitOverview class >> example [
	^ self openOn: (PBPackage example)
]

{ #category : #example }
PBLoadableUnitOverview class >> example2 [
	^ self openWithMinimalSpecOn: (PBPackage example)
]

{ #category : #specs }
PBLoadableUnitOverview class >> minimalSpec [
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
PBLoadableUnitOverview class >> newOn: anOngoingPackageVersion owner: owner [
	^ self basicNew
		initializeWith: anOngoingPackageVersion;
		yourself
]

{ #category : #opening }
PBLoadableUnitOverview class >> openOn: anOngoingPackageVersion [
	(self newOn: anOngoingPackageVersion owner: nil)
		openWithSpec
]

{ #category : #opening }
PBLoadableUnitOverview class >> openWithMinimalSpecOn: anOngoingPackageVersion [
	(self newOn: anOngoingPackageVersion owner: nil)
		openWithSpec: #minimalSpec
]

{ #category : #accessing }
PBLoadableUnitOverview >> descriptionLabel [
	^ descriptionLabel
]

{ #category : #accessing }
PBLoadableUnitOverview >> descriptionText [
	^ descriptionText
]

{ #category : #initialization }
PBLoadableUnitOverview >> initialExtent [
	 ^ (900.0@350.0)
]

{ #category : #initialization }
PBLoadableUnitOverview >> initializePresenter [
	nameInputField acceptBlock: [ self error: 'Project name should not change' ].
	versionInputField acceptBlock: [ self updateVersion ].
	repositoryInputField acceptBlock: [ self updateRepository ].
	descriptionText whenTextIsAccepted: 
		[ :newText | self updateDescription ]
]

{ #category : #initialization }
PBLoadableUnitOverview >> initializeWidgets [
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
PBLoadableUnitOverview >> initializeWith: anOngoingPackageUnit [
	super initialize.
	ongoingPackageVersion := anOngoingPackageUnit.
	self refreshWidgetValues
]

{ #category : #accessing }
PBLoadableUnitOverview >> nameInputField [
	^ nameInputField
]

{ #category : #accessing }
PBLoadableUnitOverview >> nameLabel [
	^ nameLabel
]

{ #category : #initialization }
PBLoadableUnitOverview >> refreshWidgetValues [
	nameInputField text: ongoingPackageVersion name.
	versionInputField text: ongoingPackageVersion version asString.
	ongoingPackageVersion isProject
		ifTrue: [ ongoingPackageVersion repository ifNotNil: 
			[ :repository | repositoryInputField text: repository repositoryUrl ] ].
	descriptionText text: ongoingPackageVersion description
]

{ #category : #accessing }
PBLoadableUnitOverview >> repositoryInputField [
	^ repositoryInputField
]

{ #category : #accessing }
PBLoadableUnitOverview >> repositoryLabel [
	^ repositoryLabel
]

{ #category : #updating }
PBLoadableUnitOverview >> updateDescription [
	ongoingPackageVersion description: descriptionText text asString
]

{ #category : #updating }
PBLoadableUnitOverview >> updateDescriptionWith: aString [
	ongoingPackageVersion description: aString printString
]

{ #category : #updating }
PBLoadableUnitOverview >> updateName [
	ongoingPackageVersion name: nameInputField text asSymbol printString
]

{ #category : #updating }
PBLoadableUnitOverview >> updateRepository [
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
PBLoadableUnitOverview >> updateVersion [
	| versionString |
	versionString := versionInputField text.
	versionString asSemanticVersion. "check the version string"
	ongoingPackageVersion version: versionString
]

{ #category : #accessing }
PBLoadableUnitOverview >> versionInputField [
	^ versionInputField
]

{ #category : #accessing }
PBLoadableUnitOverview >> versionLabel [
	^ versionLabel
]
