"
I'm in charge of displaying meta-information on packages.
I also allow to edit these meta-data.

I mainly interact with OnGoingPackage[Unit/Assembly]

"
Class {
	#name : #CGOPackagePanel,
	#superclass : #PBLoadableUnitPanel,
	#instVars : [
		'overview',
		'ongoingPackageUnit',
		'detailsView'
	],
	#category : #'CargoPackageManager-UI'
}

{ #category : #opening }
CGOPackagePanel class >> browsePackageMetadata: aBuilder [
	<contextMenu>
	<nautilusGlobalPackageMenu>
	| selectedPackage |
	selectedPackage := aBuilder model selectedPackage package.
	selectedPackage ifNil: [ ^ self ].
	(aBuilder item: #'Browse package metadata ...')
		action: [ self openOn: selectedPackage ];
		order: 1000
]

{ #category : #private }
CGOPackagePanel class >> buildOnOngoing: anOngoingPackageVersion [
	^ self basicNew
		initializeWith: anOngoingPackageVersion;
		buildWithSpec
]

{ #category : #specs }
CGOPackagePanel class >> defaultSpec [
	^ SpecLayout composed
		newRow: [ :row |
			row 
				add: #overview;
				add: #dependenciesView ]
]

{ #category : #example }
CGOPackagePanel class >> example [
	^ self openOnOngoing: (PBPackage example)
]

{ #category : #private }
CGOPackagePanel class >> ongoingPackageVersionFor: selectedPackage [
	| manifest ongoing |
	manifest := selectedPackage packageManifest.
	ongoing := PBPackage on: manifest.
	(manifest class selectors includes: #packageName)
		ifFalse: [ ongoing updatePackageName: selectedPackage name ].
	^ ongoing
]

{ #category : #'instance creation' }
CGOPackagePanel class >> openOn: aRPackageOrPackageName [
	^ self openOnOngoing: (self ongoingPackageVersionFor: aRPackageOrPackageName)
]

{ #category : #private }
CGOPackagePanel class >> openOnOngoing: anOngoingPackageVersion [
	^ self basicNew
		initializeWith: anOngoingPackageVersion;
		openWithSpec;
		yourself
]

{ #category : #accessing }
CGOPackagePanel >> dependenciesView [
	^ detailsView
]

{ #category : #initialization }
CGOPackagePanel >> initialExtent [
	 ^ (800.0@320.0)
]

{ #category : #initialization }
CGOPackagePanel >> initializeWidgets [
	overview := PBLoadableUnitOverviewPanel newOn: ongoingPackageUnit owner: self.
	detailsView := CGOPackageDetailsView newOn: ongoingPackageUnit owner: self.
]

{ #category : #initialization }
CGOPackagePanel >> initializeWith: anOngoingPackageUnit [
	ongoingPackageUnit := anOngoingPackageUnit.
	super initialize

]

{ #category : #accessing }
CGOPackagePanel >> overview [
	^ overview
]

{ #category : #accessing }
CGOPackagePanel >> title [
	^ 	ongoingPackageUnit packageName, ' metadata'
]
