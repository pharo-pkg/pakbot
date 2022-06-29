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

{ #category : #testing }
PBProjectCommand >> canBeExecuted [

	^ self project notNil
]

{ #category : #accessing }
PBProjectCommand >> project [

	^ project ifNil: [ 
		  self context selectedItem ifNotNil: [ :item | item project ] ]
]

{ #category : #accessing }
PBProjectCommand >> project: anObject [

	project := anObject
]
