saving
saveToSCM: commitMessage 
	self withRepositoryDo: [ :repo |
		repository := repo.
		[repo
			saveProject: self asVcsSerializedCargoProject
			withMessage: commitMessage]
			on: IceGitUsernameOrEmailNotFound 
			do: [ :error | error acceptError: (IceTipInteractiveErrorVisitor on: repository iceRepository) ] ].
	self flag: 'also implement push by asking to which remote we will push'