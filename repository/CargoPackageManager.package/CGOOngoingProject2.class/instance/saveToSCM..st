saving
saveToSCM: commitMessage 
	self withRepositoryDo: [ :repo |
		repository := repo.
		repo
			saveProject: self asVcsSerializedCargoProject
			withMessage: commitMessage ].
	self flag: 'also implement push by asking to which remote we will push'