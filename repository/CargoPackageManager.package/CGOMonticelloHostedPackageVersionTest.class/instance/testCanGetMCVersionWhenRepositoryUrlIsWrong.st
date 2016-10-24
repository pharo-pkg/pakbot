tests
testCanGetMCVersionWhenRepositoryUrlIsWrong
	| repo |
	
	repo := CGOMonticelloHostedPackageVersion 
		repositoryUrl: 'http://smalltalkhub.com/mc/foo/bla'
		packageName: 'CargoPackageManager-Minimal'
		versionString: 'ChristopheDemarey.215'.
	
	self 
		should: [ repo mcVersion ]
		raise: MCRepositoryError 