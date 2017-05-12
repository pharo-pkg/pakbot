testing
isGitRepositoryUrl: aString
	^ (aString beginsWith: 'git@') 
		or: [ aString endsWith: '.git' ]