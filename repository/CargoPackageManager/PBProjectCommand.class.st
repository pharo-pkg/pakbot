"
Abstract class for all the commands that works on projects.
"
Class {
	#name : #PBProjectCommand,
	#superclass : #CmCommand,
	#instVars : [
		'project'
	],
	#category : #'CargoPackageManager-Commands'
}

{ #category : #accessing }
PBProjectCommand >> project [

	^ project
]

{ #category : #accessing }
PBProjectCommand >> project: anObject [

	project := anObject
]
