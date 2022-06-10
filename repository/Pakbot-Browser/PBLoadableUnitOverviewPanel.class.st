"
I'm in charge of displaying core meta-information on packages.
I also allow to edit these meta-data.

I mainly interact with PBProjectElement[Unit/Assembly]
"
Class {
	#name : #PBLoadableUnitOverviewPanel,
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
PBLoadableUnitOverviewPanel class >> example [
	^ self openOn: (PBPackage example)
]

{ #category : #examples }
PBLoadableUnitOverviewPanel class >> example2 [
	^ self openWithMinimalLayoutOn: (PBPackage example)
]

{ #category : #layout }
PBLoadableUnitOverviewPanel class >> minimalLayout [

	^ SpGridLayout build: [ :builder | 
		builder
		  add: 'Name:'; add: #nameInputField; nextRow;
		  add: 'Description:'; add: #descriptionText; nextRow;
		  beColumnNotHomogeneous;
		  column: 2 withConstraints: [ :c | c beExpand ] ]
]

{ #category : #'instance creation' }
PBLoadableUnitOverviewPanel class >> on: aPBProjectElement [

	^ self
		 newApplication: self currentApplication
		 model: aPBProjectElement
]

{ #category : #opening }
PBLoadableUnitOverviewPanel class >> openOn: aPBProjectElement [

	(self on: aPBProjectElement) open
]

{ #category : #'instance creation' }
PBLoadableUnitOverviewPanel class >> openWithMinimalLayoutOn: aPBProjectElement [
	(self on: aPBProjectElement) openWithLayout: self minimalLayout
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

{ #category : #initialization }
PBLoadableUnitOverviewPanel >> initializePresenters [
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
PBLoadableUnitOverviewPanel >> loadableUnit [
	^ self model
]

{ #category : #initialization }
PBLoadableUnitOverviewPanel >> modelChanged [ 
	self loadableUnit ifNil: [ ^ self ].
	
	nameInputField text: self loadableUnit name.
	versionInputField text: self loadableUnit version asString.
	descriptionText text: self loadableUnit description
]
