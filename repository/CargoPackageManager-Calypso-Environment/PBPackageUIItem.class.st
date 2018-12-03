Class {
	#name : #PBPackageUIItem,
	#superclass : #PBAbstractUIItem,
	#instVars : [
		'package'
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
PBPackageUIItem class >> on: aPackage [
	^ self new
		package: aPackage;
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

{ #category : #testing }
PBPackageUIItem >> canBeRemovedFromAssembly [
	
	^ false
]

{ #category : #testing }
PBPackageUIItem >> canBeRemovedFromProject [
	
	^ true
]

{ #category : #accessing }
PBPackageUIItem >> cargoPackage [
	^ package
]

{ #category : #critiques }
PBPackageUIItem >> critiques [

	^ package isInstalled
		ifTrue: [ package systemPackage critiques ]
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
	^ package systemPackage extendedClasses
]

{ #category : #testing }
PBPackageUIItem >> includesClassesAffectedBy: aSystemAnnouncement [
	^ self isInstalled
		and: [ self systemPackage includesClassesAffectedBy: aSystemAnnouncement ]
]

{ #category : #querying }
PBPackageUIItem >> isAboutPackage: aRPackage [ 
	" We now have problems with extensions from project view. Let's just say no for now.
	^ self systemPackage isAboutPackage: aRPackage "
	^ false
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
	
	^ package isInstalled
]

{ #category : #accessing }
PBPackageUIItem >> items [
	^ self error: 'Should not be implemented, the packages have ClassGroups inside'
]

{ #category : #actions }
PBPackageUIItem >> load [
	self package load.
	PBPackageLoaded announceOnPackage: self package.
]

{ #category : #accessing }
PBPackageUIItem >> name [
	^ package name
]

{ #category : #accessing }
PBPackageUIItem >> package [
	^ package
]

{ #category : #accessing }
PBPackageUIItem >> package: anObject [
	package := anObject
]

{ #category : #actions }
PBPackageUIItem >> removeFromProject [
	
	^ self package project removePackage: self package
]

{ #category : #testing }
PBPackageUIItem >> representsItemOfType: aClass [

	"Awful code because of calypso"
	^ ( package class includesBehavior: aClass ) or: [ self class includesBehavior: aClass ]
]

{ #category : #accessing }
PBPackageUIItem >> systemPackage [
	
	^ package systemPackage
]
