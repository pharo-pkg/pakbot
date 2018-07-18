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

	^ aChildBrowserItem = anotherChildBrowserItemOrRPackage
		or: [ aChildBrowserItem isInstalled
				and: [ aChildBrowserItem systemPackage = anotherChildBrowserItemOrRPackage ] ]
]

{ #category : #converting }
PBPackageUIItem class >> convertToCalypsoBrowserItem: aUnit [
 
	^PBBrowserItem named: aUnit name with: aUnit
]

{ #category : #sorting }
PBPackageUIItem class >> forUnit: anUnit [
	^ self new
		unit: anUnit;
		yourself
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

	^ unit isInstalled
		ifTrue: [ unit systemPackage critiques ]
		ifFalse: [ #() ]
]

{ #category : #decorating }
PBPackageUIItem >> decorate: anItemCellMorph inContext: itemContext [
	self isInstalled
		ifTrue: [ anItemCellMorph definitionIcon: #package ]
		ifFalse: [ anItemCellMorph
				definitionMorph:
					((self iconNamed: #package) asAlphaImageMorph
						alpha: 0.6;
						yourself) ]
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
PBPackageUIItem >> items [
	^ {}
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
	^ ( unit class includesBehavior: aClass ) or: [ self class includesBehavior: aClass ]
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
