"
I'm in charge of displaying meta-information on Cargo projects.
I also allow to edit these meta-data.
"
Class {
	#name : #PBProjectPanel,
	#superclass : #PBLoadableUnitPanel,
	#instVars : [
		'overview',
		'ongoingPackageUnit',
		'dependencies',
		'projectStatus'
	],
	#category : #'CargoPackageManager-UI'
}

{ #category : #private }
PBProjectPanel class >> buildOnOngoing: anOngoingPackageVersion [
	^ self basicNew
		initializeWith: anOngoingPackageVersion;
		buildWithSpec
]

{ #category : #example }
PBProjectPanel class >> example [
	^ self basicNew
		initializeWith: PBProject example;
		openWithSpec
]

{ #category : #specs }
PBProjectPanel >> defaultSpec [

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
PBProjectPanel >> dependencies [
	^ dependencies
]

{ #category : #initialization }
PBProjectPanel >> initializeWidgets [

	overview := PBLoadableUnitOverview newOn: ongoingPackageUnit owner: self.
	dependencies := CGOPackageDependenciesView newOn: ongoingPackageUnit owner: self.
	projectStatus := CGOProjectStatusPresenter newOn: ongoingPackageUnit owner: self.
]

{ #category : #initialization }
PBProjectPanel >> initializeWith: anOngoingPackageUnit [
	ongoingPackageUnit := anOngoingPackageUnit.
	super initialize
]

{ #category : #accessing }
PBProjectPanel >> overview [
	^ overview
]

{ #category : #accessing }
PBProjectPanel >> projectStatus [

	^ projectStatus
]

{ #category : #specs }
PBProjectPanel >> refreshUI [
	self needRebuild: false.
	self buildWithSpecLayout: (self retrieveSpec: spec selector).
]

{ #category : #specs }
PBProjectPanel >> retrieveSpec: aSelector [

	| layout |
	
	layout := self perform: aSelector.
	layout isSpecLayout ifTrue: [ layout selector: aSelector ].
	^ layout
]
