Class {
	#name : #PBInteractiveErrorVisitor,
	#superclass : #PBErrorVisitor,
	#category : #'CargoPackageManager-UI-ErrorHandling'
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
