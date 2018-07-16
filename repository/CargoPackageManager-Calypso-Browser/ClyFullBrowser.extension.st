Extension { #name : #ClyFullBrowser }

{ #category : #'*CargoPackageManager-Calypso-Browser' }
ClyFullBrowser >> pakbotProjectSelection [
	^packageView selection asSelectedParentsOf: PBProjectBrowserItem 
]
