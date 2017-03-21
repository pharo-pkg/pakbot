serialization
isGitRepositoryUrl
	^ (repositoryUrl beginsWith: 'git@') 
		or: [ repositoryUrl endsWith: '.git' ]