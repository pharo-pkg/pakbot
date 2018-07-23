"
Simple editor for a virtual package.
"
Class {
	#name : #CGOVirtualPackageView,
	#superclass : #PBLoadableUnitPanel,
	#instVars : [
		'packageOverview',
		'virtualPackage'
	],
	#category : #'CargoPackageManager-UI'
}

{ #category : #private }
CGOVirtualPackageView class >> buildOnOngoing: anOngoingVirtualPackageVersion [
	^ self basicNew
		initializeWith: anOngoingVirtualPackageVersion;
		buildWithSpec
]

{ #category : #specs }
CGOVirtualPackageView class >> defaultSpec [
	^ SpecLayout composed
		add: #packageOverview withSpec: #minimalSpec
]

{ #category : #example }
CGOVirtualPackageView class >> example [
	^ self openOn: (CGOOngoingVirtualPackageVersion example)
]

{ #category : #'instance creation' }
CGOVirtualPackageView class >> newOn: anOngoingVirtualPackageVersion owner: owner [
	^ self basicNew
		initializeWith: anOngoingVirtualPackageVersion;
		yourself
]

{ #category : #'instance creation' }
CGOVirtualPackageView class >> openOn: anOngoingPackageVersion [
	(self newOn: anOngoingPackageVersion owner: nil)
		openWithSpec
]

{ #category : #configuring }
CGOVirtualPackageView >> initialExtent [
	 ^ (800.0@320.0)
]

{ #category : #initialization }
CGOVirtualPackageView >> initializeWidgets [
	packageOverview := PBLoadableUnitOverviewPanel newOn: virtualPackage owner: self.
]

{ #category : #initialization }
CGOVirtualPackageView >> initializeWith: anOngoingVirtualPackage [
	virtualPackage := anOngoingVirtualPackage.
	super initialize.
]

{ #category : #accessing }
CGOVirtualPackageView >> packageOverview [
	^ packageOverview
]
