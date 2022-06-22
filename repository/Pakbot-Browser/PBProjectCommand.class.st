"
Abstract class for all the commands that works on projects.
"
Class {
	#name : #PBProjectCommand,
	#superclass : #CmCommand,
	#instVars : [
		'project'
	],
	#category : #'Pakbot-Browser-Commands'
}

{ #category : #accessing }
PBProjectCommand >> application [
	^ context application
]

{ #category : #accessing }
PBProjectCommand >> project [

	^ project ifNil: [ self context selectedItem project ]
]

{ #category : #accessing }
PBProjectCommand >> project: anObject [

	project := anObject
]
