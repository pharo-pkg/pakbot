validation
validateEndsWithGit
	(url lastPathSegment endsWith: '.git')
		ifFalse: [ CGOGitRepositoryValidationError signal: 'Missing ''.git'' suffix!' ]