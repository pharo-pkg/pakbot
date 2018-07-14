"
I'm in charge of displaying meta-information on Cargo projects.
I also allow to edit these meta-data.
"
Class {
	#name : #CGOProjectPanel,
	#superclass : #CGOPackageView,
	#instVars : [
		'overview',
		'ongoingPackageUnit',
		'dependencies',
		'projectStatus'
	],
	#category : 'CargoPackageManager-UI'
}

{ #category : #private }
CGOProjectPanel class >> buildOnOngoing: anOngoingPackageVersion [
	^ self basicNew
		initializeWith: anOngoingPackageVersion;
		buildWithSpec
]

{ #category : #example }
CGOProjectPanel class >> example [
	^ self basicNew
		initializeWith: CGOOngoingProject example;
		openWithSpec
]

{ #category : #specs }
CGOProjectPanel >> defaultSpec [

	^ SpecLayout composed
		newColumn: [ :col |
		 col
			newRow: [ :row | row add: #projectStatus ] height: (projectStatus requiredHeight);
			newRow: [ :row | 
				row
					add: #overview;
					add: #dependencies ]]
]

{ #category : #initialization }
CGOProjectPanel >> dependencies [
	^ dependencies
]

{ #category : #initialization }
CGOProjectPanel >> initializeWidgets [

	overview := CGOPackageOverview newOn: ongoingPackageUnit owner: self.
	dependencies := CGOPackageDependenciesView newOn: ongoingPackageUnit owner: self.
	projectStatus := CGOProjectStatusPresenter newOn: ongoingPackageUnit owner: self.
]

{ #category : #initialization }
CGOProjectPanel >> initializeWith: anOngoingPackageUnit [
	ongoingPackageUnit := anOngoingPackageUnit.
	super initialize
]

{ #category : #accessing }
CGOProjectPanel >> overview [
	^ overview
]

{ #category : #accessing }
CGOProjectPanel >> projectStatus [

	^ projectStatus
]

{ #category : #specs }
CGOProjectPanel >> refreshUI [
	self needRebuild: false.
	self buildWithSpecLayout: (self retrieveSpec: spec selector).
]

{ #category : #specs }
CGOProjectPanel >> retrieveSpec: aSelector [

	| layout |
	
	layout := self perform: aSelector.
	layout isSpecLayout ifTrue: [ layout selector: aSelector ].
	^ layout
]
