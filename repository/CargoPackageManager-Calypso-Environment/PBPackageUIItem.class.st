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
	| item |

	item := PBBrowserItem named: aUnit name with: aUnit.
	item actualObject decorate: item.
	^ item.
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

{ #category : #queries }
PBPackageUIItem class >> prepareProjectItemsQueryFrom: anItem in: aNavigationEnvironment [ 
		
	^ ClyAllClassGroups from: PBProjectPackageScope ofAll: {anItem} in: aNavigationEnvironment.

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
PBPackageUIItem >> decorate: aBrowserItem [
	super decorate: aBrowserItem.

	self isEmpty ifFalse: [ aBrowserItem markWithChildrenOf: ClyClassGroup ] 
]

{ #category : #decorating }
PBPackageUIItem >> decorateTableCell: anItemCellMorph inContext: itemContext [

	self isInstalled
		ifTrue: [ anItemCellMorph definitionIcon: #package ]
		ifFalse: [ anItemCellMorph
				definitionMorph:
					((self iconNamed: #package) asAlphaImageMorph
						alpha: 0.6;
						yourself) ]
]

{ #category : #accessing }
PBPackageUIItem >> extendedClasses [

	self isInstalled
		ifFalse: [ ^ #() ].
	^ unit systemPackage extendedClasses
]

{ #category : #testing }
PBPackageUIItem >> includesClassesAffectedBy: aSystemAnnouncement [
	^ self isInstalled
		and: [ self systemPackage includesClassesAffectedBy: aSystemAnnouncement ]
]

{ #category : #announcements }
PBPackageUIItem >> isAffectedBy: anAnnouncement [
	^ (anAnnouncement isKindOf: ClassAnnouncement)
		and: [ (anAnnouncement packagesAffected collect: #name) includes: self name ]
]

{ #category : #testing }
PBPackageUIItem >> isEmpty [
	"The package is empty if there are no class tags or is not installed"
	^ self isInstalled not or: [ self systemPackage actualClassTags isEmpty ]
]

{ #category : #testing }
PBPackageUIItem >> isInstalled [
	
	^ unit isInstalled
]

{ #category : #accessing }
PBPackageUIItem >> items [
	^ self error: 'Should not be implemented, the packages have ClassGroups inside'
]

{ #category : #accessing }
PBPackageUIItem >> name [
	^ unit name
]

{ #category : #actions }
PBPackageUIItem >> removeFromProject [
	
	^ self unit project removePackage: self unit
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
