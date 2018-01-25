initialization
initializePresenter
	super initializePresenter.

	newRepositoryButton action: [ self newRepository ].
	cloneRepositoryButton action: [ self cloneRepository; delete ].
	addLocalRepositoryButton action: [ self addLocalRepository; delete ].
	
	Iceberg announcer weak 
		when: IceRepositoryCreated 
		send: #newRepositoryCreated:
		to: self.