"
I display and allow edition of package details such as the source code reference, provisions, and platform requirements.
I also use the package dependencies view.
"
Class {
	#name : #CGOPackageDetailsView,
	#superclass : #PBLoadableUnitPanel,
	#instVars : [
		'dependenciesView',
		'provisionsInputField',
		'fileInputField',
		'platformRequirementWidget',
		'editPlatformRequirementsButton'
	],
	#classInstVars : [
		'platformRequirementWidget'
	],
	#category : #'CargoPackageManager-UI'
}

{ #category : #example }
CGOPackageDetailsView class >> example [
	^ self openOn: (PBPackage example)
]

{ #category : #building }
CGOPackageDetailsView >> addPlatformRequirementTagsTo: morph [
	self ongoingPackageUnit platformRequirements do: [ :string | morph addMorph: (self tagFactory text: string asMorph) morph ]
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

{ #category : #specs }
CGOPackageDetailsView >> defaultLayout [
	^ SpBoxLayout newTopToBottom 
		add: (SpGridLayout build: [ :builder |
			builder 
				add: 'Provisions:' "width: self labelSize";
				add: provisionsInputField;
				nextRow;
				add: 'Platform requirements:' "width: 130";
				add: editPlatformRequirementsButton "width: 40"
				"add: platformRequirementWidget; list of tags"  ]);
			add: #dependenciesView;
		yourself
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
		initialAnswer: (self ongoingPackageUnit platformRequirements
			ifEmpty: [ '' ]
			ifNotEmpty: [ :string | Character space join: string ])
		title: 'Platform requirements of ' , self ongoingPackageUnit packageName , ' package'.
	requirementsString ifNil: [ ^ self ].
	self ongoingPackageUnit platformRequirements: 
		((Character space split: requirementsString)
			collect: #asSymbol
			as: Array).
	
	self updatePlatformRequirementsMorph
]

{ #category : #initialization }
CGOPackageDetailsView >> initialExtent [
	 ^ (800.0@320.0)
]

{ #category : #initialization }
CGOPackageDetailsView >> initializePresenter [
	super initializePresenter.
	editPlatformRequirementsButton action: [ self editPlatformRequirements ].
	provisionsInputField whenSubmitDo: [ self updateProvisions ].
	self refreshWidgetValues.
	
	self layout: self defaultLayout.
]

{ #category : #initialization }
CGOPackageDetailsView >> initializeWidgets [
	dependenciesView := self instantiate: CGOPackageDependenciesView on: self ongoingPackageUnit.
	provisionsInputField := self newTextInput.
	fileInputField := self newTextInput.
	editPlatformRequirementsButton := self newButton
		icon: (Smalltalk ui icons iconNamed: #editIcon);
		enabled: true;
		help: 'Edit platform requirements'.


]

{ #category : #accessing }
CGOPackageDetailsView >> ongoingPackageUnit [
	^ self model
]

{ #category : #initialization }
CGOPackageDetailsView >> refreshWidgetValues [
	provisionsInputField text: (self ongoingPackageUnit provisions
		ifEmpty: [ '' ]
		ifNotEmpty: [ Character space join: self ongoingPackageUnit provisions ]).
	"fileInputField text: ongoingPackageUnit file."
	platformRequirementWidget := self buildPlatformTagsMorph asSpecAdapter
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
	self ongoingPackageUnit provisions: provisions
]
