Class {
	#name : #PBNonInteractiveErrorVisitor,
	#superclass : #PBErrorVisitor,
	#category : #'CargoPackageManager-UI-ErrorHandling'
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
