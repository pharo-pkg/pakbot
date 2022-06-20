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

{ #category : #accessing }
PakbotBrowser >> packageRepository [
	
	^ packageRepository ifNil: [ PBPackageRepository newLocalRepositoryIn: FileLocator home / 'dev/rmod/test-pkg-repo' ]
]

{ #category : #accessing }
PakbotBrowser >> registry [
	^ registry ifNil: [ PBPackageRegistry default ]
]

{ #category : #accessing }
PakbotBrowser >> start [ 
	(self newPresenter: PBBrowserMainPresenter) open
]
