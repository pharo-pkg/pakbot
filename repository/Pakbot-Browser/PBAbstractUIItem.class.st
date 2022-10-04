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

{ #category : #building }
PBAbstractUIItem >> addExtraGroupTo: contextMenu [

	contextMenu addItem: [ :item | 
			item 
				name: 'Extra'; 
				subMenu: (SpMenuPresenter new 
					addItem: [ :subMenuItem | subMenuItem name: 'Inspect'; action: [ self inspect ] ];
					addItem: [ :subMenuItem | subMenuItem name: 'Inspect repository'; action: [ self project repository iceRepository inspect ] ];
					yourself) ]
]

{ #category : #accessing }
PBAbstractUIItem >> commands [
	^ self subclassResponsibility
]

{ #category : #building }
PBAbstractUIItem >> contextMenu [
	
	| commandGroup menu |
	commandGroup := self contextMenuCommandGroup.
	self commands do: [ :each | commandGroup register: each ].

	menu := SpMenuPresenterBuilder new 
		visitCommandGroup: commandGroup;
		menuPresenter.
	self addExtraGroupTo: menu.
	
	^ menu
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
PBAbstractUIItem >> isAssembly [
	^ false
]

{ #category : #testing }
PBAbstractUIItem >> isPackage [
	^ false
]

{ #category : #testing }
PBAbstractUIItem >> isProject [
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
