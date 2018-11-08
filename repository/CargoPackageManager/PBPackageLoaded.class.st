"
Announcement used when a package is loaded in the System.
"
Class {
	#name : #PBPackageLoaded,
	#superclass : #SystemAnnouncement,
	#instVars : [
		'package'
	],
	#category : #'CargoPackageManager-Announcements'
}

{ #category : #announcing }
PBPackageLoaded class >> announceOnPackage: aPackage [
	self new 
		package: aPackage;
		announce
]

{ #category : #announcing }
PBPackageLoaded >> announce [
	SystemAnnouncer uniqueInstance announce: self
]

{ #category : #accessing }
PBPackageLoaded >> package: aPackage [ 
	package := aPackage
]
