"
Abstract presenter used to edit pakbot project dependencies
"
Class {
	#name : #PBAbstractDependencyPresenter,
	#superclass : #SpPresenterWithModel,
	#category : #'Pakbot-Browser-Presenters-Dependencies'
}

{ #category : #testing }
PBAbstractDependencyPresenter class >> isAbstract [

	^ self name = #PBAbstractDependencyPresenter
]

{ #category : #accessing }
PBAbstractDependencyPresenter >> dependency [
	^ self model
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

{ #category : #initialization }
PBAbstractDependencyPresenter >> setInitialValues [

	self subclassResponsibility 
]

{ #category : #building }
PBAbstractDependencyPresenter >> updateDependency [

	^ self subclassResponsibility 
]

{ #category : #initialization }
PBAbstractDependencyPresenter >> updatePresenter [

	self dependency ifNotNil: [ self setInitialValues ]
]
