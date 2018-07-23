Class {
	#name : #PBAbstractUIItem,
	#superclass : #ClyProjectChildItem,
	#category : #'CargoPackageManager-Calypso-Environment-Items'
}

{ #category : #'as yet unclassified' }
PBAbstractUIItem class >> defaultSortFunctionForCalypso [
	^ [ :a :b | true ]
]

{ #category : #queries }
PBAbstractUIItem class >> prepareProjectItemsQueryFrom: aProjectItem in: aNavigationEnvironment [ 

	^ PBProjectItemContentQuery 
			sortedFrom: (PBProjectItemScope of: aProjectItem in: aNavigationEnvironment)
]

{ #category : #testing }
PBAbstractUIItem >> classes [
	
	^ #()
]

{ #category : #decorating }
PBAbstractUIItem >> decorate: aClyBrowserItem [

	self isEmpty
		ifFalse: [ aClyBrowserItem markWithChildrenOf: PBAbstractUIItem ]
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
PBAbstractUIItem >> name [
	
	^ self subclassResponsibility
]

{ #category : #testing }
PBAbstractUIItem >> representsItemOfType: aClass [ 

	self subclassResponsibility
]
