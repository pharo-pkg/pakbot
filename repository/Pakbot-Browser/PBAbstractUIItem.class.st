"
I represent an UI item used to display an abstract element of a packbot project.
"
Class {
	#name : #PBAbstractUIItem,
	#superclass : #Object,
	#category : #'Pakbot-Browser-Items'
}

{ #category : #accessing }
PBAbstractUIItem >> displayName [ 
	^ self subclassResponsibility
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

{ #category : #accessing }
PBAbstractUIItem >> project [
	
	self subclassResponsibility 
]