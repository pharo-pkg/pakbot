"
Action used to load the project metadata, its package and dependencies
"
Class {
	#name : #PBLoadFullProjectCommand,
	#superclass : #PBLoadProjectCommand,
	#category : #'Pakbot-Browser-Commands'
}

{ #category : #testing }
PBLoadFullProjectCommand class >> isAvailableFor: aProject [

	^ true
]

{ #category : #accessing }
PBLoadFullProjectCommand >> description [

	^ 'Loads all the packages of a project and their dependencies.'
]

{ #category : #executing }
PBLoadFullProjectCommand >> doExecute [
	
	project load
]

{ #category : #accessing }
PBLoadFullProjectCommand >> iconName [

	^ #smallLoadProject
]

{ #category : #accessing }
PBLoadFullProjectCommand >> name [

	^ 'Load the whole project'
]
