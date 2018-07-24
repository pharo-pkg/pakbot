Extension { #name : #CGOGitRepository }

{ #category : #'*CargoPackageManager-UI' }
CGOGitRepository >> description [
	
	^ self iceRepository remotes anyOne url asString
]

{ #category : #'*CargoPackageManager-UI' }
CGOGitRepository >> iconName [
	
	^ #git
]
