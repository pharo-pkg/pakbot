"
Subclass me to provide a new way of loading a project.
My subclasses are dynamically collected by `PBLoadProjectPresenter`.
"
Class {
	#name : #PBLoadProjectAction,
	#superclass : #PBAbstractAction,
	#category : #'Pakbot-Browser-Actions'
}

{ #category : #accessing }
PBLoadProjectAction class >> allAvailableFor: aProject [

	^ self allSubclasses 
		select: [ :aClass | aClass isAvailableFor: aProject ] 
		thenCollect: [ :aClass | aClass forProject: aProject ]
]

{ #category : #testing }
PBLoadProjectAction class >> isAvailableFor: aProject [

	^ self subclassResponsibility
]

{ #category : #accessing }
PBLoadProjectAction >> description [

	^ self subclassResponsibility
]

{ #category : #accessing }
PBLoadProjectAction >> iconName [

	^ self subclassResponsibility
]

{ #category : #accessing }
PBLoadProjectAction >> name [

	^ self subclassResponsibility 
]
