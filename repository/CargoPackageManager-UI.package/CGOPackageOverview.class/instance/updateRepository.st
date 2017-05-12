updating
updateRepository
	| repositoryString repository subdirectory |
	repositoryString := repositoryInputField text.
	(CGOSourceRepository isGitRepositoryUrl: repositoryString)
		ifTrue: [ subdirectory := UIManager default 
		request: 'Subdirectory for git repository (leave it empty if none)' 
		initialAnswer: ''. ].
	repository := CGOSourceRepository 
		fromStringUrl: repositoryString 
		subdirectory:  subdirectory.
	ongoingPackageVersion repository: repository.