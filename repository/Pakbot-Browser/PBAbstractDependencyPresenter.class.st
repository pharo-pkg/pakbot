"
Abstract presenter used to edit pakbot project dependencies
"
Class {
	#name : #PBAbstractDependencyPresenter,
	#superclass : #SpOptionPresenter,
	#instVars : [
		'dependency'
	],
	#category : #'Pakbot-Browser-Presenters-Dependencies'
}

{ #category : #testing }
PBAbstractDependencyPresenter class >> isAbstract [

	^ self name = #PBAbstractDependencyPresenter
]

{ #category : #accessing }
PBAbstractDependencyPresenter >> dependency [
	^ dependency
]

{ #category : #initialization }
PBAbstractDependencyPresenter >> initializePresenters [

	self dependency ifNotNil: [ self setInitialValues ]
]

{ #category : #validation }
PBAbstractDependencyPresenter >> isValid [
	
	self flag: 'TODO: all fields are required! Ensure they are all filled before accept'.
	^ true
]

{ #category : #opening }
PBAbstractDependencyPresenter >> openDialogOnAccept: acceptBlock onCancel: cancelBlock [
	| dialog |
	
	dialog := self openDialog
		okAction: [ "check if valid"
			self updateDependency.
			acceptBlock cull: self ];
		cancelAction: [ cancelBlock cull: self ];
		yourself.

	self whenChangedDo: [ dialog toolbar okButton enabled: self isValid ].

	^ dialog
]

{ #category : #'option list presenter' }
PBAbstractDependencyPresenter >> optionIcon [

	^ self icon
]

{ #category : #'option list presenter' }
PBAbstractDependencyPresenter >> optionTitle [ 

	^ self title
]

{ #category : #initialization }
PBAbstractDependencyPresenter >> setInitialValues [

	self subclassResponsibility 
]

{ #category : #initialization }
PBAbstractDependencyPresenter >> setModelBeforeInitialization: aPakbotDependency [

	dependency := aPakbotDependency
]

{ #category : #building }
PBAbstractDependencyPresenter >> updateDependency [

	^ self subclassResponsibility 
]

{ #category : #initialization }
PBAbstractDependencyPresenter >> updatePresenter [

	self dependency ifNotNil: [ self setInitialValues ]
]
