tests
testUrlValidationFailsIfDoesNotEndWithDotGit
	self 
		should: [ CGOGitRepositoryCreator new
			url: 'git+ssh://git@github.com/demarey/pharo-counter';
			version: 'master';
			create ]
		raise: CGOGitRepositoryValidationError