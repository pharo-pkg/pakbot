Class {
	#name : #PBProjectContentQuery,
	#superclass : #ClyTypedQuery,
	#category : #'CargoPackageManager-Calypso-Environment-Queries'
}

{ #category : #accessing }
PBProjectContentQuery class >> resultItemsType [
	^ PBProjectChildBrowserItem
]

{ #category : #execution }
PBProjectContentQuery >> buildResult: aQueryResult [

	aQueryResult fillWith: scope project items
]

{ #category : #execution }
PBProjectContentQuery >> checkEmptyResult [
	
	^ scope project isEmpty
]

{ #category : #'system changes' }
PBProjectContentQuery >> collectMetadataOf: aQueryResult by: anEnvironmentPlugin [


]

{ #category : #'system changes' }
PBProjectContentQuery >> isResult: aQueryResult affectedBy: aSystemAnnouncement [

	^true
]
