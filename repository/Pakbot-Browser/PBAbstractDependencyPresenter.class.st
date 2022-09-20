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
	
	| report |
	report := self validate.
	^ report	hasErrors not
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

{ #category : #updating }
PBAbstractDependencyPresenter >> updateDependency [

	^ self subclassResponsibility 
]

{ #category : #updating }
PBAbstractDependencyPresenter >> updateOkButton [ 

	self withWindowDo: [ :window | window okButton enabled: self isValid ] 
]

{ #category : #updating }
PBAbstractDependencyPresenter >> updatePresenter [

	self dependency ifNotNil: [ self setInitialValues ]
]
