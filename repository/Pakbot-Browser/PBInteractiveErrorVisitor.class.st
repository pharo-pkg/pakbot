"
When a Pakbot error occurs while being in interactive mode, we handle it and display a presenter with the error.
"
Class {
	#name : #PBInteractiveErrorVisitor,
	#superclass : #PBErrorVisitor,
	#category : #'Pakbot-Browser-ErrorHandling'
}

{ #category : #'instance creation' }
PBInteractiveErrorVisitor class >> isActive [ 

	^ Smalltalk isInteractive
]

{ #category : #'instance creation' }
PBInteractiveErrorVisitor class >> priority [
	
	^ 100
]

{ #category : #visiting }
PBInteractiveErrorVisitor >> visitGenericError: anException [

	^ (ITErrorDialog on: anException) openDialogWithSpec
]

{ #category : #visiting }
PBInteractiveErrorVisitor >> visitProjectWithConflictsError: anError [

	^ self visitGenericError: anError
]
