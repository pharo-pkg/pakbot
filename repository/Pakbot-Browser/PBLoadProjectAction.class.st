"
See `PBLoadProjectAction>>#description`
"
Class {
	#name : #PBLoadProjectAction,
	#superclass : #PBRepairProjectAction,
	#category : #'Pakbot-Browser-Actions'
}

{ #category : #accessing }
PBLoadProjectAction class >> isAvailableFor: aProject [

	^ aProject isUpToDate not
]

{ #category : #accessing }
PBLoadProjectAction >> description [
	^ 'Loads the missing dependencies of the project. 
If there is a conflict it should be fixed before being able to load the dependencies.'
]

{ #category : #execution }
PBLoadProjectAction >> doExecute [

	^ (PBLoadPreviewPresenter on: project resolve) openDialog
]

{ #category : #accessing }
PBLoadProjectAction >> iconName [

	^ #smallLoadProject
]

{ #category : #accessing }
PBLoadProjectAction >> name [

	^ 'Load Dependencies of the Project'
]
