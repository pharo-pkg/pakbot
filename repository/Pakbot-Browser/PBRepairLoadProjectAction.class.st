"
See `PBLoadProjectAction>>#description`
"
Class {
	#name : #PBRepairLoadProjectAction,
	#superclass : #PBRepairProjectAction,
	#category : #'Pakbot-Browser-Actions'
}

{ #category : #accessing }
PBRepairLoadProjectAction class >> isAvailableFor: aProject [

	^ aProject isUpToDate not
]

{ #category : #accessing }
PBRepairLoadProjectAction >> description [
	^ 'Loads the missing dependencies of the project. 
If there is a conflict it should be fixed before being able to load the dependencies.'
]

{ #category : #execution }
PBRepairLoadProjectAction >> doExecute [

	^ (PBLoadPreviewPresenter on: project resolve) openDialog
]

{ #category : #accessing }
PBRepairLoadProjectAction >> iconName [

	^ #smallLoadProject
]

{ #category : #accessing }
PBRepairLoadProjectAction >> name [

	^ 'Load Dependencies of the Project'
]
