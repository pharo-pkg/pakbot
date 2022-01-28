"
I'm in charge of displaying core meta-information on packages.
I also allow to edit these meta-data.

I mainly interacte with OnGoingPackage[Unit/Assembly]

"
Class {
	#name : #PBLoadableUnitOverviewPanel,
	#superclass : #PBLoadableUnitPanel,
	#instVars : [
		'nameInputField',
		'versionInputField',
		'descriptionText',
		'registry',
		'autoAccept',
		'repositoryInputField'
	],
	#category : #'CargoPackageManager-UI'
}

{ #category : #example }
PBLoadableUnitOverviewPanel class >> example [
	^ self openOn: (PBPackage example)
]

{ #category : #example }
PBLoadableUnitOverviewPanel class >> example2 [
	^ self openWithMinimalLayoutOn: (PBPackage example)
]

{ #category : #specs }
PBLoadableUnitOverviewPanel class >> minimalLayout [

	^ SpGridLayout new
		  add: 'Name:' at: 1 @ 1;
		  add: #nameInputField at: 2 @ 1;
		  add: 'Description:' at: 1 @ 2;
		  add: #descriptionText at: 2 @ 2;
		  columnHomogeneous: false;
		  column: 2 withConstraints: [ :c | c beExpand ];
		  yourself
]

{ #category : #'instance creation' }
PBLoadableUnitOverviewPanel class >> newOn: aPBLoadableUnit owner: owner [
	^ self 
		newApplication: self currentApplication 
		owner: owner
		model: aPBLoadableUnit
]

{ #category : #opening }
PBLoadableUnitOverviewPanel class >> openOn: anOngoingPackageVersion [

	(self newOn: anOngoingPackageVersion owner: nil) open
]

{ #category : #opening }
PBLoadableUnitOverviewPanel class >> openWithMinimalLayoutOn: anOngoingPackageVersion [
	(self newOn: anOngoingPackageVersion owner: nil)
		openWithLayout: self minimalLayout
]

{ #category : #initialization }
PBLoadableUnitOverviewPanel >> accept [

	self
		updateName;
		updateVersion;
		updateDescription
]

{ #category : #accessing }
PBLoadableUnitOverviewPanel >> autoAccept [
	^ autoAccept
]

{ #category : #accessing }
PBLoadableUnitOverviewPanel >> autoAccept: anObject [
	autoAccept := anObject
]

{ #category : #initialization }
PBLoadableUnitOverviewPanel >> connectPresenters [

	"nameInputField acceptBlock: [ self error: 'Project name should not change' ]."
	versionInputField whenSubmitDo: [ self updateVersion ].
	descriptionText whenSubmitDo: 
		[ :newText | self updateDescription ].
	self refreshWidgetValues
]

{ #category : #layout }
PBLoadableUnitOverviewPanel >> defaultLayout [

	^ (SpGridLayout build: [ :builder | 
			   builder
				   add: 'Name:';
				   add: nameInputField;
				   nextRow;
				   add: 'Version:';
				   add: versionInputField;
				   nextRow;
				   add: 'Repository:';
				   add: repositoryInputField;
				   nextRow;
				   add: 'Description:';
				   add: descriptionText ])
		  columnHomogeneous: false;
		  column: 2 withConstraints: [ :c | c beExpand ];
		  yourself
]

{ #category : #accessing }
PBLoadableUnitOverviewPanel >> description: aString [
	descriptionText text: aString
]

{ #category : #initialization }
PBLoadableUnitOverviewPanel >> initialExtent [
	 ^ (900.0@350.0)
]

{ #category : #initialization }
PBLoadableUnitOverviewPanel >> initialize [

	registry := PBPackageRegistry default.
	super initialize.
]

{ #category : #initialization }
PBLoadableUnitOverviewPanel >> initializePresenters [
	self newTextInputField: #nameInputField description: 'MyProject'.
	self newTextInputField: #versionInputField description: '1.0.0'.
	repositoryInputField := self instantiate: PBRepositoryInputField on: self loadableUnit.
	descriptionText := self newText
]

{ #category : #accessing }
PBLoadableUnitOverviewPanel >> loadableUnit [
	^ self model
]

{ #category : #accessing }
PBLoadableUnitOverviewPanel >> name: aString [
	nameInputField text: aString
]

{ #category : #initialization }
PBLoadableUnitOverviewPanel >> refreshWidgetValues [
	nameInputField text: self loadableUnit name.
	versionInputField text: self loadableUnit version asString.
	descriptionText text: self loadableUnit description
]

{ #category : #accessing }
PBLoadableUnitOverviewPanel >> registry [
	^ registry
]

{ #category : #accessing }
PBLoadableUnitOverviewPanel >> registry: aCGOPackageRegistry [

	registry := aCGOPackageRegistry 
]

{ #category : #updating }
PBLoadableUnitOverviewPanel >> updateDescription [
	self loadableUnit description: descriptionText text asString
]

{ #category : #updating }
PBLoadableUnitOverviewPanel >> updateName [
	self loadableUnit name: nameInputField text asSymbol
]

{ #category : #updating }
PBLoadableUnitOverviewPanel >> updateVersion [
	| versionString |
	versionString := versionInputField text.
	self loadableUnit version: versionString asSemanticVersion
]

{ #category : #accessing }
PBLoadableUnitOverviewPanel >> version: aString [
	versionInputField text: aString
]
