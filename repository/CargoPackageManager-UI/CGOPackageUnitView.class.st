"
Simple editor for a package unit.
It is a composition of a package overview and a package dependency view
"
Class {
	#name : #CGOPackageUnitView,
	#superclass : #PBLoadableUnitPanel,
	#instVars : [
		'packageOverview',
		'ongoingPackageUnit',
		'detailsView'
	],
	#category : #'CargoPackageManager-UI'
}

{ #category : #private }
CGOPackageUnitView class >> buildOnOngoing: anOngoingPackageVersion [
	^ self basicNew
		initializeWith: anOngoingPackageVersion;
		buildWithSpec
]

{ #category : #specs }
CGOPackageUnitView class >> defaultSpec [
	^ SpecLayout composed
		newRow: [ :row |
			row
				add: #packageOverview withSpec: #minimalLayout;
				add: #detailsView ]
]

{ #category : #example }
CGOPackageUnitView class >> example [
	^ self openOn: (PBPackage example)
]

{ #category : #'instance creation' }
CGOPackageUnitView class >> newOn: anOngoingPackageUnit owner: owner [
	^ self basicNew
		initializeWith: anOngoingPackageUnit;
		yourself
]

{ #category : #'instance creation' }
CGOPackageUnitView class >> openOn: anOngoingPackageVersion [
	(self newOn: anOngoingPackageVersion owner: nil)
		openWithSpec
]

{ #category : #accessing }
CGOPackageUnitView >> detailsView [
	^ detailsView 
]

{ #category : #configuring }
CGOPackageUnitView >> initialExtent [
	 ^ (800.0@320.0)
]

{ #category : #initialization }
CGOPackageUnitView >> initializeWidgets [
	packageOverview := self instantiate: PBLoadableUnitOverviewPanel on: ongoingPackageUnit.
	detailsView := self instantiate: CGOPackageDetailsView on: ongoingPackageUnit.
]

{ #category : #accessing }
CGOPackageUnitView >> packageOverview [
	^  packageOverview
]

{ #category : #initialization }
CGOPackageUnitView >> setModelBeforeInitialization: aModel [
	ongoingPackageUnit := aModel
]
