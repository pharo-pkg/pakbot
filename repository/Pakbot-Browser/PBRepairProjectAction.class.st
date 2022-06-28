"
I represent a repair actions that can be executed on a project with problems.
I have a class message #allAvailableFor: that returns all the applicable repair actions for the status of a given project.
"
Class {
	#name : #PBRepairProjectAction,
	#superclass : #PBAbstractAction,
	#category : #'Pakbot-Browser-Actions'
}

{ #category : #accessing }
PBRepairProjectAction class >> allAvailableFor: aProject [

	^ self allSubclasses 
		select: [ :aClass | aClass isAvailableFor: aProject ] 
		thenCollect: [ :aClass | aClass forProject: aProject ]
]

{ #category : #accessing }
PBRepairProjectAction class >> isAvailableFor: aProject [

	^ self subclassResponsibility
]

{ #category : #accessing }
PBRepairProjectAction >> description [

	^ self subclassResponsibility
]

{ #category : #accessing }
PBRepairProjectAction >> iconName [

	^ self subclassResponsibility
]

{ #category : #accessing }
PBRepairProjectAction >> name [

	^ self subclassResponsibility 
]
