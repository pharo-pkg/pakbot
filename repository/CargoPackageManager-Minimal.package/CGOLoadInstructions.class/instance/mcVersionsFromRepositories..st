loading
mcVersionsFromRepositories: aRepositoryList
	^ groups collect: 
		[ :group | 
			group 	addAllRepositories: aRepositoryList;
					mcVersions ]