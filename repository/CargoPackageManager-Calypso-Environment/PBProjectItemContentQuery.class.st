Class {
	#name : #PBProjectItemContentQuery,
	#superclass : #ClyTypedQuery,
	#category : #'CargoPackageManager-Calypso-Environment-Queries'
}

{ #category : #accessing }
PBProjectItemContentQuery class >> resultItemsType [
	^ PBAbstractUIItem
]

{ #category : #execution }
PBProjectItemContentQuery >> buildResult: aQueryResult [

	aQueryResult fillWith: scope item items
]

{ #category : #execution }
PBProjectItemContentQuery >> checkEmptyResult [
	
	^ scope project isEmpty
]

{ #category : #'system changes' }
PBProjectItemContentQuery >> collectMetadataOf: aQueryResult by: anEnvironmentPlugin [


]

{ #category : #'system changes' }
PBProjectItemContentQuery >> isResult: aQueryResult affectedBy: aSystemAnnouncement [
	
	^ aSystemAnnouncement isKindOf: CGOProjectAnnouncement 
]
