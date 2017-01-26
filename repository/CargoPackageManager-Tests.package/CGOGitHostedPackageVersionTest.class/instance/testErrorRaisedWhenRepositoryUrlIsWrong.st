tests
testErrorRaisedWhenRepositoryUrlIsWrong
	| repo |
	
	repo := CGOGitHostedPackageVersion 
		repositoryUrl: 'git@foo.org:foo/bar.git'
		subdirectory: 'repository'
		packageName: 'CargoPackageManager-Minimal'
		commitish: '21'.
	
	self 
		should: [ repo mcVersion ]
		raise: LGit_GIT_ERROR ", MCFileTreeGitError (gitfiletree not included in the default distribution)"