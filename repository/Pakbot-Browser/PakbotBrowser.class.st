"
A simple browser to browse Pakbot projects, display information on them and run actions.
"
Class {
	#name : #PakbotBrowser,
	#superclass : #SpApplication,
	#instVars : [
		'projectName',
		'registry'
	],
	#category : #'Pakbot-Browser-Presenters'
}

{ #category : #accessing }
PakbotBrowser >> registry [
	^ registry ifNil: [ PBPackageRegistry default ]
]

{ #category : #accessing }
PakbotBrowser >> start [ 
	(self newPresenter: PBBrowserMainPresenter) open
]
