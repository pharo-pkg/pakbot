"
Simple editor for a package assembly.
It is a composition of a package overview and an assmebly parts view
"
Class {
	#name : #CGOPackageAssemblyView,
	#superclass : #CGOPackageView,
	#instVars : [
		'ongoingPackageAssembly',
		'partsView',
		'packageOverview'
	],
	#category : 'CargoPackageManager-UI'
}

{ #category : #private }
CGOPackageAssemblyView class >> buildOnOngoing: anOngoingPackageVersion [
	^ self basicNew
		initializeWith: anOngoingPackageVersion;
		buildWithSpec
]

{ #category : #specs }
CGOPackageAssemblyView class >> defaultSpec [
	^ SpecLayout composed
		newRow: [ :row |
			row
				add: #packageOverview  withSpec: #minimalSpec;
				add: #partsView ]
]

{ #category : #example }
CGOPackageAssemblyView class >> example [
	^ self openOn: (PBAssembly example)
]

{ #category : #'instance creation' }
CGOPackageAssemblyView class >> newOn: anOngoingPackageAssembly owner: owner [
	^ self basicNew
		initializeWith: anOngoingPackageAssembly;
		yourself
]

{ #category : #'instance creation' }
CGOPackageAssemblyView class >> openOn: anOngoingPackageVersion [
	(self newOn: anOngoingPackageVersion owner: nil)
		openWithSpec
]

{ #category : #initialization }
CGOPackageAssemblyView >> initialExtent [
	 ^ (800.0@320.0)
]

{ #category : #initialization }
CGOPackageAssemblyView >> initializeWidgets [
	packageOverview := CGOPackageOverview newOn: ongoingPackageAssembly owner: self.
	partsView := CGOPackageAssemblyPartsView newOn: ongoingPackageAssembly owner: self.
]

{ #category : #initialization }
CGOPackageAssemblyView >> initializeWith: anOngoingPackageAssembly [
	ongoingPackageAssembly := anOngoingPackageAssembly.
	super initialize.
]

{ #category : #accessing }
CGOPackageAssemblyView >> packageOverview [
	^  packageOverview
]

{ #category : #accessing }
CGOPackageAssemblyView >> partsView [
	^ partsView 
]
