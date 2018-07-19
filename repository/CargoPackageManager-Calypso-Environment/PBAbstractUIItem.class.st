Class {
	#name : #PBAbstractUIItem,
	#superclass : #Object,
	#category : #'CargoPackageManager-Calypso-Environment-Items'
}

{ #category : #preparing }
PBAbstractUIItem class >> decorateBrowserItem: aBrowserItem by: anEnvironmentPlugin [

	aBrowserItem actualObject decorate: aBrowserItem.
	
]

{ #category : #'as yet unclassified' }
PBAbstractUIItem class >> defaultSortFunctionForCalypso [
	^ClySortByNameFunction ascending
]

{ #category : #queries }
PBAbstractUIItem class >> prepareProjectItemsQueryFrom: aProjectItem in: aNavigationEnvironment [ 

	^ PBProjectItemContentQuery 
			sortedFrom: (PBProjectItemScope of: aProjectItem in: aNavigationEnvironment)
]

{ #category : #decorating }
PBAbstractUIItem >> decorate: aClyBrowserItem [

	self isEmpty
		ifFalse: [ aClyBrowserItem markWithChildrenOf: PBAbstractUIItem ]
]

{ #category : #decorating }
PBAbstractUIItem >> decorate: anItemCellMorph inContext: itemContext [

	self subclassResponsibility
]

{ #category : #announcements }
PBAbstractUIItem >> isAffectedBy: anAnnouncement [ 
	
	^ self subclassResponsibility 
]

{ #category : #decorating }
PBAbstractUIItem >> isEmpty [

	^ self items isEmpty 
]

{ #category : #accessing }
PBAbstractUIItem >> items [ 
	^ self subclassResponsibility
]

{ #category : #testing }
PBAbstractUIItem >> representsItemOfType: aClass [ 

	self subclassResponsibility
]
