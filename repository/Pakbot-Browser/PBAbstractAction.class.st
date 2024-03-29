"
I execute an action by taking care of capturing errors and provide them to the default error visitor 
"
Class {
	#name : #PBAbstractAction,
	#superclass : #Object,
	#instVars : [
		'project'
	],
	#category : #'Pakbot-Browser-Actions'
}

{ #category : #'instance creation' }
PBAbstractAction class >> forProject: aProject [

	^ self new
		project: aProject;
		yourself
]

{ #category : #execution }
PBAbstractAction >> doExecute [
	^ self subclassResponsibility 
]

{ #category : #execution }
PBAbstractAction >> execute [

	[ ^ self doExecute ]
		on: PBError
		do: [ :ex | ex acceptVisitor: PBErrorVisitor default ]
]

{ #category : #acccessing }
PBAbstractAction >> project [

	^ project
]

{ #category : #acccessing }
PBAbstractAction >> project: aProject [
	project := aProject
]
