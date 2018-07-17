Class {
	#name : #PBAllPakbotProjects,
	#superclass : #ClyAllProjects,
	#category : #'CargoPackageManager-Calypso-Environment-Queries'
}

{ #category : #'items type' }
PBAllPakbotProjects class >> resultItemsType [
	
	^PBProjectUIItem
]

{ #category : #'system changes' }
PBAllPakbotProjects >> isResult: aQueryResult affectedBy: aSystemAnnouncement [

	^ aSystemAnnouncement isKindOf: CGOProjectAnnouncement
]
