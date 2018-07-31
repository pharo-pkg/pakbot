Class {
	#name : #CGOLoadProjectAction,
	#superclass : #CGORepairProjectAction,
	#category : 'CargoPackageManager-UI-Repair'
}

{ #category : #accessing }
CGOLoadProjectAction class >> isAvailableFor: aProject [

	^ aProject isUpToDate not
]

{ #category : #accessing }
CGOLoadProjectAction >> description [
	^ 'Loads the missing dependencies of the project. 
If there is a conflict it should be fixed before being able to load the dependencies.'
]

{ #category : #execution }
CGOLoadProjectAction >> doExecute [

	^ (PBLoadPreviewDialog on: project resolve) openDialogWithSpec
]

{ #category : #accessing }
CGOLoadProjectAction >> iconName [
	^ #smallLoadProject
]

{ #category : #testing }
CGOLoadProjectAction >> isLoadProjectAction [

	^ true
]

{ #category : #accessing }
CGOLoadProjectAction >> name [
	^ 'Load Dependencies of the Project'
]
