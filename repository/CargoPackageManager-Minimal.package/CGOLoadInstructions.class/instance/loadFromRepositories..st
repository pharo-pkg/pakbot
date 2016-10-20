loading
loadFromRepositories: aRepositoryList
	groups 
		do: [ :group | 
				group 
					addAllRepositories: aRepositoryList;
					load ]
		displayingProgress: [ :group | 'Installing ' , group name ]