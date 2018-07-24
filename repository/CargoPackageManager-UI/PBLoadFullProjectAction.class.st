"
Action used to load all packages of a project.
I'm dynamically collected by PBLoadProjectDialog.
"
Class {
	#name : #PBLoadFullProjectAction,
	#superclass : #PBLoadProjectAction,
	#category : #'CargoPackageManager-UI-Loading'
}

{ #category : #querying }
PBLoadFullProjectAction class >> isAvailableFor: aProject [ 
	^ true
]

{ #category : #accessing }
PBLoadFullProjectAction >> description [
	^ 'Loads all the packages of a project and their dependencies.'
]

{ #category : #execution }
PBLoadFullProjectAction >> execute [
	"project load "
]

{ #category : #accessing }
PBLoadFullProjectAction >> iconName [
	^ #smallLoadProject
]

{ #category : #accessing }
PBLoadFullProjectAction >> name [
	^ 'Load the whole project'
]
