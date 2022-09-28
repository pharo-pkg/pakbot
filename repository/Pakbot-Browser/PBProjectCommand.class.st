"
Abstract class for all the commands that works on projects.
"
Class {
	#name : #PBProjectCommand,
	#superclass : #PBCommand,
	#instVars : [
		'project'
	],
	#category : #'Pakbot-Browser-Commands'
}

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
