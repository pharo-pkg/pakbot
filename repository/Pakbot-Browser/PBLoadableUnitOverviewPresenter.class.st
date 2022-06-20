"
I'm in charge of displaying core meta-information on packages.
I also allow to edit these meta-data.

I mainly interact with PBProjectElement[Unit/Assembly]
"
Class {
	#name : #PBLoadableUnitOverviewPresenter,
	#superclass : #SpPresenterWithModel,
	#instVars : [
		'nameInputField',
		'versionInputField',
		'descriptionText',
		'repositoryInputField'
	],
	#category : #'Pakbot-Browser-Presenters'
}

{ #category : #examples }
PBLoadableUnitOverviewPresenter class >> example [
	^ self openOn: (PBPackage example)
]

{ #category : #examples }
PBLoadableUnitOverviewPresenter class >> example2 [
	^ self openWithMinimalLayoutOn: (PBPackage example)
]

{ #category : #layout }
PBLoadableUnitOverviewPresenter class >> minimalLayout [

	^ SpGridLayout build: [ :builder | 
		builder
		  add: 'Name:'; add: #nameInputField; nextRow;
		  add: 'Description:'; add: #descriptionText; nextRow;
		  beColumnNotHomogeneous;
		  column: 2 withConstraints: [ :c | c beExpand ] ]
]

{ #category : #'instance creation' }
PBLoadableUnitOverviewPresenter class >> on: aPBProjectElement [

	^ self
		 newApplication: self currentApplication
		 model: aPBProjectElement
]

{ #category : #opening }
PBLoadableUnitOverviewPresenter class >> openOn: aPBProjectElement [

	(self on: aPBProjectElement) open
]

{ #category : #'instance creation' }
PBLoadableUnitOverviewPresenter class >> openWithMinimalLayoutOn: aPBProjectElement [
	(self on: aPBProjectElement) openWithLayout: self minimalLayout
]

{ #category : #layout }
PBLoadableUnitOverviewPresenter >> defaultLayout [

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
PBLoadableUnitOverviewPresenter >> description [
	^ descriptionText text
]

{ #category : #accessing }
PBLoadableUnitOverviewPresenter >> description: aString [
	descriptionText text: aString
]

{ #category : #initialization }
PBLoadableUnitOverviewPresenter >> initializePresenters [
	nameInputField := self newTextInput
		text: 'MyProject';
		yourself.
	versionInputField := self newTextInput
		text: '1.0.0';
		yourself.	
	repositoryInputField := self instantiate: PBRepositoryPresenter on: self loadableUnit.
	descriptionText := self newText.
]

{ #category : #accessing }
PBLoadableUnitOverviewPresenter >> loadableUnit [
	^ self model
]

{ #category : #initialization }
PBLoadableUnitOverviewPresenter >> modelChanged [ 
	self loadableUnit ifNil: [ ^ self ].
	
	nameInputField text: self loadableUnit name.
	versionInputField text: self loadableUnit version asString.
	descriptionText text: (self loadableUnit description ifNil: ['']).
	repositoryInputField model: self loadableUnit
]

{ #category : #accessing }
PBLoadableUnitOverviewPresenter >> name [
	^ nameInputField text
]

{ #category : #accessing }
PBLoadableUnitOverviewPresenter >> name: aString [
	nameInputField text: aString
]

{ #category : #accessing }
PBLoadableUnitOverviewPresenter >> registry [
	^ self application registry
]

{ #category : #accessing }
PBLoadableUnitOverviewPresenter >> repository [
	^ repositoryInputField repository 
]

{ #category : #accessing }
PBLoadableUnitOverviewPresenter >> version [
	^ versionInputField text asSemanticVersion
]

{ #category : #accessing }
PBLoadableUnitOverviewPresenter >> version: aString [
	versionInputField text: aString
]
