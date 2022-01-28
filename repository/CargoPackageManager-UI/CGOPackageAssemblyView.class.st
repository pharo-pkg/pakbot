"
Simple editor for a package assembly.
It is a composition of a package overview and an assmebly parts view
"
Class {
	#name : #CGOPackageAssemblyView,
	#superclass : #PBLoadableUnitPanel,
	#instVars : [
		'partsView',
		'packageOverview'
	],
	#category : #'CargoPackageManager-UI'
}

{ #category : #private }
CGOPackageAssemblyView class >> buildOnOngoing: anOngoingPackageVersion [
	^ self basicNew
		initializeWith: anOngoingPackageVersion;
		buildWithSpec
]

{ #category : #example }
CGOPackageAssemblyView class >> example [
	^ self openOn: (PBAssembly example)
]

{ #category : #specs }
CGOPackageAssemblyView >> defaultSpec [
	packageOverview layout: packageOverview minimalLayout.
	
	^ SpBoxLayout newLeftToRight 
		add: packageOverview;
		add: partsView;
		yourself
]

{ #category : #initialization }
CGOPackageAssemblyView >> initialExtent [
	 ^ (800.0@320.0)
]

{ #category : #initialization }
CGOPackageAssemblyView >> initializeWidgets [
	packageOverview := PBLoadableUnitOverviewPanel newOn: self ongoingPackageAssembly owner: self.
	partsView := CGOPackageAssemblyPartsView newOn: self ongoingPackageAssembly owner: self.
]

{ #category : #accessing }
CGOPackageAssemblyView >> ongoingPackageAssembly [
	^ self model
]
