"
When a Pakbot error occurs while being in non-interactive mode, we do not handle it and pass it to the next handler.
"
Class {
	#name : #PBNonInteractiveErrorVisitor,
	#superclass : #PBErrorVisitor,
	#category : #'Pakbot-Browser-ErrorHandling'
}

{ #category : #'instance creation' }
PBNonInteractiveErrorVisitor class >> isActive [ 

	^ true
]

{ #category : #'instance creation' }
PBNonInteractiveErrorVisitor class >> priority [
	
	^ 0
]

{ #category : #visiting }
PBNonInteractiveErrorVisitor >> visitGenericError: anException [

	^ anException pass
]

{ #category : #visiting }
PBNonInteractiveErrorVisitor >> visitProjectWithConflictsError: anError [
	
	^ self visitGenericError: anError
]
