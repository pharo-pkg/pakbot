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
				add: #packageOverview withSpec: #minimalSpec;
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
	packageOverview := PBLoadableUnitOverviewPanel newOn: ongoingPackageUnit owner: self.
	detailsView := CGOPackageDetailsView newOn: ongoingPackageUnit owner: self.
]

{ #category : #initialization }
CGOPackageUnitView >> initializeWith: anongoingPackageUnit [
	ongoingPackageUnit := anongoingPackageUnit.
	super initialize.
]

{ #category : #accessing }
CGOPackageUnitView >> packageOverview [
	^  packageOverview
]
