"
I trigger the project repair action
"
Class {
	#name : #PBOpenRepairDialogAction,
	#superclass : #PBAbstractAction,
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
	^ (CGORepairProjectDialog onProject: project) openDialog
]

{ #category : #execution }
PBOpenRepairDialogAction >> execute [
	^ (CGORepairProjectDialog onProject: project) openDialogWithSpec 
]
