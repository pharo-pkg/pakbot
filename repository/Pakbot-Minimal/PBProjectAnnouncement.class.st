"
I represent all the announcements in Cargo Projects
"
Class {
	#name : #PBProjectAnnouncement,
	#superclass : #SystemAnnouncement,
	#instVars : [
		'project'
	],
	#category : #'Pakbot-Minimal-Announcements'
}

{ #category : #announcing }
PBProjectAnnouncement class >> announceOnProject: aProject [
	
	(self onProject: aProject) announce
]

{ #category : #'instance creation' }
PBProjectAnnouncement class >> onProject: aProject [

	^ self new
		project: aProject;
		yourself
]

{ #category : #announcing }
PBProjectAnnouncement >> announce [

	Pakbot announcer announce: self
]

{ #category : #accessing }
PBProjectAnnouncement >> project [
	^ project
]

{ #category : #accessing }
PBProjectAnnouncement >> project: anObject [
	project := anObject
]
