Extension { #name : #CGOGitRepository }

{ #category : #'*CargoPackageManager-UI' }
CGOGitRepository >> description [
	
	iceRepository remotes ifEmpty: [ ^ 'No remote configured for this project' ].
	^ iceRepository remotes anyOne url
]

{ #category : #'*CargoPackageManager-UI' }
CGOGitRepository >> iconName [
	
	^ #git
]
