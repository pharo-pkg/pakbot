updating - ui
setSourceRepositories
	self setSourceRepositoriesWithInitialSelection:
		(self repositories asSet 
			ifEmpty: [ self repositoriesCandidates asSet ]
			ifNotEmpty: [ :repositoryLocations | 
				repositoryLocations collect: [:each | MCRepository fromUrl: each ]] )