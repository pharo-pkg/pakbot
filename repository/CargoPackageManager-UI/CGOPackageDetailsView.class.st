"
I display and allow edition of package details such as the source code reference, provisions, and platform requirements.
I also use the package dependencies view.
"
Class {
	#name : #CGOPackageDetailsView,
	#superclass : #CGOPackageView,
	#instVars : [
		'ongoingPackageUnit',
		'dependenciesView',
		'provisionsLabel',
		'provisionsInputField',
		'fileLabel',
		'fileInputField',
		'platformRequirementsLabel',
		'platformRequirementWidget',
		'editPlatformRequirementsButton'
	],
	#classInstVars : [
		'platformRequirementWidget'
	],
	#category : 'CargoPackageManager-UI'
}

{ #category : #specs }
CGOPackageDetailsView class >> defaultSpec [
	^ SpecLayout composed
		newColumn: [ :column |
			column
				newRow: [ :provisionsRow |
					provisionsRow 
						add: #provisionsLabel width: self labelSize;
						add: #provisionsInputField ]
				height: self inputTextHeight;
				newRow: [ :platformRow |
					platformRow 
						add: #platformRequirementsLabel width: 130;
						add: #editPlatformRequirementsButton width: 40;
						add: #platformRequirementWidget ]
				height: self inputTextHeight;
				add: #dependenciesView";
				newRow: [ :fileRow |
					fileRow 
						add: #fileLabel width: self labelSize;
						add: #fileInputField ]
				height: self inputTextHeight" ]
]

{ #category : #example }
CGOPackageDetailsView class >> example [
	^ self openOn: (PBPackage example)
]

{ #category : #'instance creation' }
CGOPackageDetailsView class >> newOn: anOngoingPackageVersion owner: owner [
	^ self basicNew
		initializeWith: anOngoingPackageVersion;
		yourself
]

{ #category : #opening }
CGOPackageDetailsView class >> openOn: anOngoingPackageVersion [
	(self newOn: anOngoingPackageVersion owner: nil)
		openWithSpec
]

{ #category : #building }
CGOPackageDetailsView >> addPlatformRequirementTagsTo: morph [
	ongoingPackageUnit platformRequirements do: [ :string | morph addMorph: (self tagFactory text: string asMorph) morph ]
]

{ #category : #building }
CGOPackageDetailsView >> buildPlatformTagsMorph [
	| morph |
	morph := Morph new
		color: Color transparent;
		layoutPolicy: RowLayout new;
		cellInset: 10;
		yourself.
	self addPlatformRequirementTagsTo: morph.
	^ morph
]

{ #category : #accessing }
CGOPackageDetailsView >> dependenciesView [
	^ dependenciesView
]

{ #category : #actions }
CGOPackageDetailsView >> editPlatformRequirements [
	| requirementsString |
	requirementsString := UIManager default
		request: 'Platform requirements for this package (or empty if no constraint)'
		initialAnswer: (ongoingPackageUnit platformRequirements
			ifEmpty: [ '' ]
			ifNotEmpty: [ :string | Character space join: string ])
		title: 'Platform requirements of ' , ongoingPackageUnit packageName , ' package'.
	requirementsString ifNil: [ ^ self ].
	ongoingPackageUnit platformRequirements: 
		((Character space split: requirementsString)
			collect: #asSymbol
			as: Array).
	
	self updatePlatformRequirementsMorph
]

{ #category : #accessing }
CGOPackageDetailsView >> editPlatformRequirementsButton [
	^ editPlatformRequirementsButton
]

{ #category : #accessing }
CGOPackageDetailsView >> fileInputField [
	^ fileInputField
]

{ #category : #accessing }
CGOPackageDetailsView >> fileLabel [
	^ fileLabel
]

{ #category : #initialization }
CGOPackageDetailsView >> initialExtent [
	 ^ (800.0@320.0)
]

{ #category : #initialization }
CGOPackageDetailsView >> initializePresenter [
	super initializePresenter.
	editPlatformRequirementsButton action: [ self editPlatformRequirements ].
	provisionsInputField acceptBlock: [ self updateProvisions ].
]

{ #category : #initialization }
CGOPackageDetailsView >> initializeWidgets [
	dependenciesView := CGOPackageDependenciesView newOn: ongoingPackageUnit owner: self.

	(provisionsLabel := self newLabel)
		label: 'Provisions:'.
	self newTextInputField: #provisionsInputField.
	
	(fileLabel := self newLabel)
		label: 'File:'.
	self newTextInputField: #fileInputField.
	
	(platformRequirementsLabel := self newLabel)
		label: 'Platform requirements:'.
	editPlatformRequirementsButton := self newButton
		label: nil;
		icon: (Smalltalk ui icons iconNamed: #editIcon);
		enabled: true;
		help: 'Edit platform requirements'.


]

{ #category : #initialization }
CGOPackageDetailsView >> initializeWith: anOngoingPackageUnit [
	ongoingPackageUnit := anOngoingPackageUnit.
	super initialize.
	self refreshWidgetValues
]

{ #category : #accessing }
CGOPackageDetailsView >> ongoingPackageUnit [
	^ ongoingPackageUnit
]

{ #category : #accessing }
CGOPackageDetailsView >> platformRequirementWidget [
	^ platformRequirementWidget
]

{ #category : #accessing }
CGOPackageDetailsView >> platformRequirementsLabel [
	^ platformRequirementsLabel
]

{ #category : #accessing }
CGOPackageDetailsView >> provisionsInputField [
	^ provisionsInputField
]

{ #category : #accessing }
CGOPackageDetailsView >> provisionsLabel [
	^ provisionsLabel
]

{ #category : #initialization }
CGOPackageDetailsView >> refreshWidgetValues [
	provisionsInputField text: (ongoingPackageUnit provisions
		ifEmpty: [ '' ]
		ifNotEmpty: [ Character space join: ongoingPackageUnit provisions ]).
	"fileInputField text: ongoingPackageUnit file."
	platformRequirementWidget := self buildPlatformTagsMorph asSpecAdapter
]

{ #category : #private }
CGOPackageDetailsView >> tagFactory [
	^ TagMorphFactory new
		color: Color lightBlue;
		yourself
]

{ #category : #'updating - ui' }
CGOPackageDetailsView >> updatePlatformRequirementsMorph [
	platformRequirementWidget morph removeAllMorphs.
	self addPlatformRequirementTagsTo: platformRequirementWidget morph
]

{ #category : #actions }
CGOPackageDetailsView >> updateProvisions [
	| provisions |
	provisions := (Character space split: provisionsInputField text) 
		collect: #asSymbol as: Array.
	ongoingPackageUnit provisions: provisions
]
