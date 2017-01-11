tests
testErrorRaisedWhenRepositoryUrlIsWrong
	| repo |
	
	repo := CGOGitHostedPackageVersion 
		repositoryUrl: 'git@foor.org:foo/bar.git'
		subdirectory: 'repository'
		packageName: 'CargoPackageManager-Minimal'
		commitish: '21'.
	
	self 
		should: [ repo mcVersion ]
		raise: MCFileTreeGitError, LGit_GIT_ERROR