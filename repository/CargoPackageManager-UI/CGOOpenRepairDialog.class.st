Class {
	#name : #CGOOpenRepairDialog,
	#superclass : #Object,
	#instVars : [
		'project'
	],
	#category : 'CargoPackageManager-UI-Actions'
}

{ #category : #'as yet unclassified' }
CGOOpenRepairDialog class >> onProject: aProject [

	^ self new
		project: aProject;
		yourself
]

{ #category : #execution }
CGOOpenRepairDialog >> execute [
	^ (CGORepairProjectDialog onProject: project) openDialogWithSpec 
]

{ #category : #acccessing }
CGOOpenRepairDialog >> project: aProject [
	project := aProject
]
