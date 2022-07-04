"
Subclass me to provide a new way of loading a project.
My subclasses are dynamically collected by `PBLoadProjectPresenter`.
"
Class {
	#name : #PBLoadProjectCommand,
	#superclass : #PBProjectCommand,
	#category : #'Pakbot-Browser-Commands'
}

{ #category : #accessing }
PBLoadProjectCommand class >> allAvailableFor: aProject [

	^ (self allSubclasses 
		select: [ :aClass | aClass isAvailableFor: aProject ] 
		thenCollect: [ :aClass | aClass forProject: aProject ]) flattened
]

{ #category : #testing }
PBLoadProjectCommand class >> isAvailableFor: aProject [

	^ self subclassResponsibility
]

{ #category : #converting }
PBLoadProjectCommand >> asSpecCommand [
	^ super asSpecCommand
		iconName: self iconName;
		name: self name;
		beDisabledWhenCantBeRun;
		yourself
]

{ #category : #accessing }
PBLoadProjectCommand >> description [

	^ self subclassResponsibility
]

{ #category : #executing }
PBLoadProjectCommand >> doExecute [
	^ self subclassResponsibility 
]

{ #category : #executing }
PBLoadProjectCommand >> execute [

	[ ^ self doExecute ]
		on: PBError
		do: [ :ex | ex acceptVisitor: PBErrorVisitor default ]
]

{ #category : #accessing }
PBLoadProjectCommand >> iconName [

	^ self subclassResponsibility
]

{ #category : #accessing }
PBLoadProjectCommand >> name [

	^ self subclassResponsibility 
]
