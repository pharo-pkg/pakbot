Class {
	#name : #PBProjectChildBrowserItem,
	#superclass : #Object,
	#instVars : [
		'unit'
	],
	#category : #'CargoPackageManager-Calypso-Environment-Items'
}

{ #category : #converting }
PBProjectChildBrowserItem class >> convertToCalypsoBrowserItem: aUnit [
 
	^ClyBrowserItem named: aUnit name with: aUnit
]

{ #category : #sorting }
PBProjectChildBrowserItem class >> defaultSortFunctionForCalypso [
	^ClySortByNameFunction ascending
]

{ #category : #sorting }
PBProjectChildBrowserItem class >> forUnit: anUnit [
	^ self new
		unit: anUnit;
		yourself
]

{ #category : #queries }
PBProjectChildBrowserItem class >> prepareClassQueriesFrom: packages in: aNavigationEnvironment [
	| packagesToShow |
	
	packagesToShow := packages
		select: [ :each | each isInstalled ]
		thenCollect: [ :each | each systemPackage ].
	
	^ RPackage prepareClassQueriesFrom: packagesToShow in: aNavigationEnvironment
]

{ #category : #testing }
PBProjectChildBrowserItem >> isInstalled [
	
	^ unit isInstalled
]

{ #category : #accessing }
PBProjectChildBrowserItem >> name [
	^ unit name
]

{ #category : #accessing }
PBProjectChildBrowserItem >> systemPackage [
	
	^ unit systemPackage
]

{ #category : #accessing }
PBProjectChildBrowserItem >> unit [
	^ unit
]

{ #category : #accessing }
PBProjectChildBrowserItem >> unit: anObject [
	unit := anObject
]
