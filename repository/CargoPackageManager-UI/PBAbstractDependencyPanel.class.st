Class {
	#name : #PBAbstractDependencyPanel,
	#superclass : #ITOptionPanel,
	#instVars : [
		'form',
		'dependency'
	],
	#category : #'CargoPackageManager-UI-NewDependency'
}

{ #category : #specs }
PBAbstractDependencyPanel class >> defaultSpec [
	<spec: #default>

	^ SpecLayout composed 
		newColumn: #form
]

{ #category : #testing }
PBAbstractDependencyPanel class >> isAbstract [

	^ self name = #PBAbstractDependencyPanel
]

{ #category : #building }
PBAbstractDependencyPanel >> buildDependency [

	^ self subclassResponsibility 
]

{ #category : #accessing }
PBAbstractDependencyPanel >> form [
	^ form
]

{ #category : #initialization }
PBAbstractDependencyPanel >> initializeForm [

	self subclassResponsibility 
]

{ #category : #initialization }
PBAbstractDependencyPanel >> initializeWidgets [
	self initializeForm.
	self setInitialValues.
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
			acceptBlock cull: dependency ];
		cancelAction: [ cancelBlock cull: dependency ];
		yourself.

	self whenChangedDo: [ dialog toolbar okButton enabled: self isValid ].

	^ dialog
]

{ #category : #initialization }
PBAbstractDependencyPanel >> setInitialValues [

	self subclassResponsibility 
]

{ #category : #initialization }
PBAbstractDependencyPanel >> setModelBeforeInitialization: aDependency [
	
	dependency := aDependency
]

{ #category : #building }
PBAbstractDependencyPanel >> updateDependency [
	^ self subclassResponsibility 
]
