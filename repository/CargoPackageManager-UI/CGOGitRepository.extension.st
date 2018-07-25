Extension { #name : #CGOGitRepository }

{ #category : #'*CargoPackageManager-UI' }
CGOGitRepository >> description [
	
	^ self repositoryUrl 
]

{ #category : #'*CargoPackageManager-UI' }
CGOGitRepository >> iconName [
	
	^ #git
]
