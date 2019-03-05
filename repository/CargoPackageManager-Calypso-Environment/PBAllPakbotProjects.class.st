Class {
	#name : #PBAllPakbotProjects,
	#superclass : #ClyAllProjectsQuery,
	#category : #'CargoPackageManager-Calypso-Environment-Queries'
}

{ #category : #'items type' }
PBAllPakbotProjects class >> resultItemsType [
	
	^PBProjectUIItem
]

{ #category : #execution }
PBAllPakbotProjects >> buildResult: aQueryResult [
	| projects |
	projects := OrderedCollection new.
	
	scope projectsDo: [ :each | 
		projects add: each
	].

	aQueryResult fillWith: projects
]

{ #category : #execution }
PBAllPakbotProjects >> collectMetadataOf: aClySortedQueryResult by: aClyDefaultSystemEnvironmentPlugin [ 
	
	
]

{ #category : #'system changes' }
PBAllPakbotProjects >> isResult: aQueryResult affectedBy: aSystemAnnouncement [

	^ aSystemAnnouncement isKindOf: CGOProjectAnnouncement
]
