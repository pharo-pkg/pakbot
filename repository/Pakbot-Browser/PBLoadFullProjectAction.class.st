"
Action used to load the project metadata, its package and dependencies
"
Class {
	#name : #PBLoadFullProjectAction,
	#superclass : #PBLoadProjectAction,
	#category : #'Pakbot-Browser-Actions'
}

{ #category : #testing }
PBLoadFullProjectAction class >> isAvailableFor: aProject [

	^ true
]

{ #category : #accessing }
PBLoadFullProjectAction >> description [

	^ 'Loads all the packages of a project and their dependencies.'
]

{ #category : #execution }
PBLoadFullProjectAction >> doExecute [
	
	project load
]

{ #category : #accessing }
PBLoadFullProjectAction >> iconName [

	^ #smallLoadProject
]

{ #category : #accessing }
PBLoadFullProjectAction >> name [

	^ 'Load the whole project'
]
