Class {
	#name : #PBProjectContentQuery,
	#superclass : #ClyProjectContentQuery,
	#category : #'CargoPackageManager-Calypso-Environment'
}

{ #category : #accessing }
PBProjectContentQuery class >> resultItemsType [
	^ PBProjectChildBrowserItem
]

{ #category : #execution }
PBProjectContentQuery >> buildResult: aQueryResult [

	self halt
]

{ #category : #execution }
PBProjectContentQuery >> checkEmptyResult [
	
	self halt.
	scope projectsDo: [ :each | 
		each items ifNotEmpty: [ ^false ]  ].
	^true
]

{ #category : #'system changes' }
PBProjectContentQuery >> collectMetadataOf: aQueryResult by: anEnvironmentPlugin [

	self halt
]

{ #category : #'system changes' }
PBProjectContentQuery >> isResult: aQueryResult affectedBy: aSystemAnnouncement [

	^true
]
