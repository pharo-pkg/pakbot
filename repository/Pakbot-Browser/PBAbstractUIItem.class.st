"
I represent an UI item used to display an abstract element of a packbot project.

My `presenter` instance variable holds a reference to the presenter I belong to.
"
Class {
	#name : #PBAbstractUIItem,
	#superclass : #Object,
	#instVars : [
		'presenter'
	],
	#category : #'Pakbot-Browser-Items'
}

{ #category : #accessing }
PBAbstractUIItem >> commands [
	^ self subclassResponsibility
]

{ #category : #building }
PBAbstractUIItem >> contextMenu [
	
	| commandGroup |
	commandGroup := self contextMenuCommandGroup.
	self commands do: [ :each | commandGroup register: each ].

	^ SpMenuPresenterBuilder new 
		visitCommandGroup: commandGroup;
		menuPresenter
]

{ #category : #private }
PBAbstractUIItem >> contextMenuCommandGroup [

	^ (CmCommandGroup named: 'Context Menu') asSpecGroup
			beDisplayedAsGroup;
			yourself
]

{ #category : #accessing }
PBAbstractUIItem >> displayName [ 
	^ self subclassResponsibility
]

{ #category : #accessing }
PBAbstractUIItem >> icon [
	^ self iconNamed: self iconName
]

{ #category : #accessing }
PBAbstractUIItem >> iconName [ 
	^ self subclassResponsibility
]

{ #category : #testing }
PBAbstractUIItem >> isPackage [
	^ false
]

{ #category : #accessing }
PBAbstractUIItem >> items [ 
	^ self subclassResponsibility
]

{ #category : #accessing }
PBAbstractUIItem >> pakbotItem [
	
	self subclassResponsibility 
]

{ #category : #initialization }
PBAbstractUIItem >> presenter: aSpPresenter [ 
	presenter := aSpPresenter
]

{ #category : #accessing }
PBAbstractUIItem >> project [
	
	self subclassResponsibility 
]
