"
I'm an abstract Pakbot command.
I allow to access the presenter and its application I got from the context.
"
Class {
	#name : #PBCommand,
	#superclass : #CmCommand,
	#category : #'Pakbot-Browser-Commands'
}

{ #category : #accessing }
PBCommand >> application [
	
	^ self presenter application
]

{ #category : #accessing }
PBCommand >> presenter [

	^ context
]

{ #category : #refreshing }
PBCommand >> refreshPresenter [

	self presenter refresh
]

{ #category : #refreshing }
PBCommand >> refreshPresenterKeepingSelection [

	self presenter refreshKeepingSelection
]
