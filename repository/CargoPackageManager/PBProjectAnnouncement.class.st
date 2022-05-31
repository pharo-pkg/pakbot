"
I represent all the announcements in Cargo Projects
"
Class {
	#name : #PBProjectAnnouncement,
	#superclass : #SystemAnnouncement,
	#instVars : [
		'project'
	],
	#category : #'CargoPackageManager-Announcements'
}

{ #category : #'as yet unclassified' }
PBProjectAnnouncement class >> announceOnProject: aProject [
	
	(self onProject: aProject) announce
]

{ #category : #'as yet unclassified' }
PBProjectAnnouncement class >> onProject: aProject [

	^ self new
		project: aProject;
		yourself
]

{ #category : #announcing }
PBProjectAnnouncement >> announce [

	SystemAnnouncer uniqueInstance announce: self
]

{ #category : #accessing }
PBProjectAnnouncement >> project [
	^ project
]

{ #category : #accessing }
PBProjectAnnouncement >> project: anObject [
	project := anObject
]
