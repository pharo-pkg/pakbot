Class {
	#name : #PBOpenRepairDialogAction,
	#superclass : #PBAbstractAction,
	#instVars : [
		'project'
	],
	#category : #'CargoPackageManager-UI-Actions'
}

{ #category : #'instance-creation' }
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
