Class {
	#name : #PBPackageUIItem,
	#superclass : #PBAbstractUIItem,
	#instVars : [
		'unit'
	],
	#category : #'CargoPackageManager-Calypso-Environment-Items'
}

{ #category : #queries }
PBPackageUIItem class >> checkCalypsoItem: aChildBrowserItem isEqualTo: anotherChildBrowserItemOrRPackage [
		
	^ aChildBrowserItem = anotherChildBrowserItemOrRPackage or: [ aChildBrowserItem systemPackage = anotherChildBrowserItemOrRPackage ]
]

{ #category : #converting }
PBPackageUIItem class >> convertToCalypsoBrowserItem: aUnit [
 
	^PBBrowserItem named: aUnit name with: aUnit
]

{ #category : #sorting }
PBPackageUIItem class >> defaultSortFunctionForCalypso [
	^ClySortByNameFunction ascending
]

{ #category : #sorting }
PBPackageUIItem class >> forUnit: anUnit [
	^ self new
		unit: anUnit;
		yourself
]

{ #category : #queries }
PBPackageUIItem class >> prepareClassGroupQueryFrom: aPackage in: aNavigationEnvironment [

	^ ClyAllClassGroups sortedFrom: (PBProjectPackageScope of: aPackage in: aNavigationEnvironment)
		

]

{ #category : #queries }
PBPackageUIItem class >> prepareClassQueriesFrom: packages in: aNavigationEnvironment [
		
	^ { ClyAllClasses from: PBProjectPackageScope ofAll: packages in: aNavigationEnvironment }.

]

{ #category : #accessing }
PBPackageUIItem >> cargoPackage [
	^ unit
]

{ #category : #critiques }
PBPackageUIItem >> critiques [
	
	^ unit systemPackage critiques
]

{ #category : #decorating }
PBPackageUIItem >> decorate: anItemCellMorph inContext: itemContext [
	
	anItemCellMorph definitionIcon: #package
]

{ #category : #testing }
PBPackageUIItem >> includesClassesAffectedBy: aSystemAnnouncement [ 
	
	^ false
]

{ #category : #testing }
PBPackageUIItem >> isInstalled [
	
	^ unit isInstalled
]

{ #category : #accessing }
PBPackageUIItem >> name [
	^ unit name
]

{ #category : #actions }
PBPackageUIItem >> removeFromProject [
	
	^ self unit project removePart: self unit
]

{ #category : #testing }
PBPackageUIItem >> representsItemOfType: aClass [

	"Awful code because of calypso"
	^ ( aClass = unit class ) or: [ aClass = self class ]
]

{ #category : #accessing }
PBPackageUIItem >> systemPackage [
	
	^ unit systemPackage
]

{ #category : #accessing }
PBPackageUIItem >> unit [
	^ unit
]

{ #category : #accessing }
PBPackageUIItem >> unit: anObject [
	unit := anObject
]
