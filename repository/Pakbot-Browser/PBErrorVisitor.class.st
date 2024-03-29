"
A simple visitor to handle Pakbot errors.
"
Class {
	#name : #PBErrorVisitor,
	#superclass : #Object,
	#category : #'Pakbot-Browser-ErrorHandling'
}

{ #category : #'instance creation' }
PBErrorVisitor class >> default [
	
	(self allSubclasses sorted: [ :a :b | a priority > b priority ])
		select: [ :each | each isActive ]
		thenDo: [ :first | ^ first new ].
		
	self error: 'There is no Error visitor.... we should not be here'.
]

{ #category : #'instance creation' }
PBErrorVisitor class >> isActive [

	^ self subclassResponsibility
]

{ #category : #'instance creation' }
PBErrorVisitor class >> priority [ 

	^ self subclassResponsibility
]

{ #category : #visiting }
PBErrorVisitor >> visitGenericError: anError [

	self subclassResponsibility
]

{ #category : #visiting }
PBErrorVisitor >> visitProjectWithConflictsError: anError [
	
	self subclassResponsibility 
]
