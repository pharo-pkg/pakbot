Class {
	#name : #PBAbstractDependencyPanel,
	#superclass : #SpPresenterWithModel,
	#instVars : [
		'form'
	],
	#category : #'CargoPackageManager-UI-NewDependency'
}

{ #category : #testing }
PBAbstractDependencyPanel class >> isAbstract [

	^ self name = #PBAbstractDependencyPanel
]

{ #category : #building }
PBAbstractDependencyPanel >> buildDependency [

	^ self subclassResponsibility 
]

{ #category : #specs }
PBAbstractDependencyPanel >> defaultLayout [
	
	^ SpBoxLayout newTopToBottom 
		add: form;
		yourself
]

{ #category : #accessing }
PBAbstractDependencyPanel >> dependency [
	^ self model
]

{ #category : #initialization }
PBAbstractDependencyPanel >> initializeForm [

	self subclassResponsibility 
]

{ #category : #initialization }
PBAbstractDependencyPanel >> initializeWidgets [
	self initializeForm.

	self dependency ifNotNil: [ self setInitialValues ].
	
	self layout: self defaultLayout.
]

{ #category : #validation }
PBAbstractDependencyPanel >> isValid [
	^ form isValid
]

{ #category : #opening }
PBAbstractDependencyPanel >> openDialogOnAccept: acceptBlock onCancel: cancelBlock [
	| dialog |
	
	dialog := self openDialogWithSpec
		okAction: [ 
			self updateDependency.
			acceptBlock cull: self dependency ];
		cancelAction: [ cancelBlock cull: self dependency ];
		yourself.

	self whenChangedDo: [ dialog toolbar okButton enabled: self isValid ].

	^ dialog
]

{ #category : #initialization }
PBAbstractDependencyPanel >> setInitialValues [

	self subclassResponsibility 
]

{ #category : #building }
PBAbstractDependencyPanel >> updateDependency [
	^ self subclassResponsibility 
]
