Extension { #name : #PBGitRepository }

{ #category : #'*CargoPackageManager-UI' }
PBGitRepository >> description [
	
	iceRepositoryCreator ifNotNil: [ ^ iceRepositoryCreator remote url ].
	
	^ self iceRepository remotes 
		ifEmpty: [ 'No remote configured for this project' ]
		ifNotEmpty: [ :remotes | remotes anyOne url ]
]

{ #category : #'*CargoPackageManager-UI' }
PBGitRepository >> iconName [
	
	^ #git
]
