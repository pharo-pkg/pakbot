action
repositoryFromIceRepository: anIceRepository 
	^ CGOGitRepository 
		url: anIceRepository origin url
		repository: anIceRepository
		version: anIceRepository branchName