Extension { #name : #PBGitRepository }

{ #category : #'*CargoPackageManager-UI' }
PBGitRepository >> description [
	
	[ ^ iceRepository remote url ] "IceRepositoryCreator"
		on: MessageNotUnderstood
		do: [ iceRepository remotes 
			ifEmpty: [ ^ 'No remote configured for this project' ] ].
	
	^ iceRepository remotes anyOne url
]

{ #category : #'*CargoPackageManager-UI' }
PBGitRepository >> iconName [
	
	^ #git
]
