Class {
	#name : #PBProjectChildBrowserItem,
	#superclass : #Object,
	#instVars : [
		'unit'
	],
	#category : #'CargoPackageManager-Calypso-Environment-Items'
}

{ #category : #queries }
PBProjectChildBrowserItem class >> checkCalypsoItem: aChildBrowserItem isEqualTo: anotherChildBrowserItemOrRPackage [
		
	^ aChildBrowserItem = anotherChildBrowserItemOrRPackage or: [ aChildBrowserItem systemPackage = anotherChildBrowserItemOrRPackage ]
]

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
		
	^ { ClyAllClasses from: PBProjectPackageScope ofAll: packages in: aNavigationEnvironment }.

]

{ #category : #testing }
PBProjectChildBrowserItem >> includesClassesAffectedBy: aSystemAnnouncement [ 
	
	^ false
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
