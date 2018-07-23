Class {
	#name : #PBOpenRepairDialogAction,
	#superclass : #PBAbstractAction,
	#instVars : [
		'project'
	],
	#category : #'CargoPackageManager-UI-Actions'
}

{ #category : #'as yet unclassified' }
PBOpenRepairDialogAction class >> onProject: aProject [

	^ self new
		project: aProject;
		yourself
]

{ #category : #execution }
PBOpenRepairDialogAction >> doExecute [
	^ (CGORepairProjectDialog onProject: project) openDialogWithSpec 
]

{ #category : #execution }
PBOpenRepairDialogAction >> execute [
	^ (CGORepairProjectDialog onProject: project) openDialogWithSpec 
]

{ #category : #acccessing }
PBOpenRepairDialogAction >> project: aProject [
	project := aProject
]
