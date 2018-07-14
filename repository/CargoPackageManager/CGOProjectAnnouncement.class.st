"
I represent all the announcements in Cargo Projects
"
Class {
	#name : #CGOProjectAnnouncement,
	#superclass : #SystemAnnouncement,
	#instVars : [
		'project'
	],
	#category : 'CargoPackageManager-Announcements'
}

{ #category : #'as yet unclassified' }
CGOProjectAnnouncement class >> announceOnProject: aProject [
	
	(self onProject: aProject) announce
]

{ #category : #'as yet unclassified' }
CGOProjectAnnouncement class >> onProject: aProject [

	^ self new
		project: aProject;
		yourself
]

{ #category : #announcing }
CGOProjectAnnouncement >> announce [

	SystemAnnouncer uniqueInstance announce: self
]

{ #category : #accessing }
CGOProjectAnnouncement >> project [
	^ project
]

{ #category : #accessing }
CGOProjectAnnouncement >> project: anObject [
	project := anObject
]
