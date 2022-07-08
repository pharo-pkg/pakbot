"
A simple browser to browse Pakbot projects, display information on them and run actions.
"
Class {
	#name : #PakbotBrowser,
	#superclass : #SpApplication,
	#instVars : [
		'projectName',
		'registry',
		'packageRepository'
	],
	#category : #'Pakbot-Browser-Presenters'
}

{ #category : #initialization }
PakbotBrowser >> initialize [ 

	super initialize.
	self
		useBackend: #Morphic 
		with: PakbotBrowserConfiguration new.
]

{ #category : #accessing }
PakbotBrowser >> mainPresenter [ 
	
	^ self newPresenter: PBBrowserMainPresenter
]

{ #category : #accessing }
PakbotBrowser >> packageRepository [
	
	^ packageRepository ifNil: [ PBPackageRepository default ]
]

{ #category : #accessing }
PakbotBrowser >> registry [
	^ registry ifNil: [ PBPackageRegistry default ]
]

{ #category : #accessing }
PakbotBrowser >> registry: aPBRegistry [
	
	registry := aPBRegistry
]

{ #category : #actions }
PakbotBrowser >> start [ 
	self mainPresenter open
]

{ #category : #actions }
PakbotBrowser >> startWithoutActions [
	self mainPresenter 
		disableActions;
		open
]
